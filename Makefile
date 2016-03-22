# Makefile

# container-tools - Manage systemd-nspawn containers
# Copyright (C) 2014-2016 Daniel Baumann <daniel.baumann@open-infrastructure.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

SHELL := sh -e

SOFTWARE = container-tools
SCRIPTS = bin/* lib/*/*

all: build

test:
	@echo -n "Checking for syntax errors"

	@for SCRIPT in $(SCRIPTS); \
	do \
		sh -n $${SCRIPT}; \
		echo -n "."; \
	done

	@echo " done."

	@echo -n "Checking for bashisms"

	@if [ -x /usr/bin/checkbashisms ]; \
	then \
		for SCRIPT in $(SCRIPTS); \
		do \
			checkbashisms -f -x $${SCRIPT}; \
			echo -n "."; \
		done; \
	else \
		echo "Note: devscripts not installed, skipping checkbashisms."; \
	fi

	@echo " done."

build: share/man/*.txt
	$(MAKE) -C share/man

install: build
	mkdir -p $(DESTDIR)/etc/container-tools/config
	mkdir -p $(DESTDIR)/etc/container-tools/debconf

	mkdir -p $(DESTDIR)/usr/bin
	cp -r bin/* $(DESTDIR)/usr/bin

	mkdir -p $(DESTDIR)/usr/lib/$(SOFTWARE)
	cp -r lib/* $(DESTDIR)/usr/lib/$(SOFTWARE)

	mkdir -p $(DESTDIR)/usr/share/$(SOFTWARE)
	cp -r VERSION.txt share/config share/scripts ${DESTDIR}/usr/share/$(SOFTWARE)

	mkdir -p $(DESTDIR)/usr/share/doc/$(SOFTWARE)
	cp -r share/doc $(DESTDIR)/usr/share/doc/$(SOFTWARE)

	for SECTION in $$(seq 1 8); \
	do \
		if ls share/man/*.$${SECTION} > /dev/null 2>&1; \
		then \
			mkdir -p $(DESTDIR)/usr/share/man/man$${SECTION}; \
			cp share/man/*.$${SECTION} $(DESTDIR)/usr/share/man/man$${SECTION}; \
		fi; \
	done

	ln -s container.1 $(DESTDIR)/usr/share/man/man1/cnt.1
	ln -s container-shell.1 $(DESTDIR)/usr/share/man/man1/cntsh.1

	mkdir -p $(DESTDIR)/lib/systemd/system
	cp -r share/systemd/* $(DESTDIR)/lib/systemd/system

uninstall:
	for FILE in share/systemd*; \
	do \
		if [ -e "$${FILE}" ]; \
		then \
			rm -f $(DESTDIR)/lib/systemd/system/$$(basename $${FILE}); \
		fi; \
	done

	for SECTION in $$(seq 1 8); \
	do \
		for FILE in share/man/*.$${SECTION}; \
		do \
			if [ -e "$${FILE}" ]; \
			then \
				rm -f $(DESTDIR)/usr/share/man/man$${SECTION}/$$(basename $${FILE}); \
			fi; \
		done; \
		rmdir --ignore-fail-on-non-empty --parents $(DESTDIR)/usr/share/man/man$${SECTION} || true; \
	done

	rm -f $(DESTDIR)/usr/share/man/man1/cnt.1
	rm -f $(DESTDIR)/usr/share/man/man1/cntsh.1

	rm -rf $(DESTDIR)/usr/share/doc/$(SOFTWARE)
	rmdir --ignore-fail-on-non-empty --parents $(DESTDIR)/usr/share/doc || true

	rm -rf $(DESTDIR)/usr/share/$(SOFTWARE)
	rmdir --ignore-fail-on-non-empty --parents $(DESTDIR)/usr/share || true

	rm -rf $(DESTDIR)/usr/lib/$(SOFTWARE)
	rmdir --ignore-fail-on-non-empty --parents $(DESTDIR)/usr/lib || true

	for FILE in bin/*; \
	do \
		rm -f $(DESTDIR)/usr/bin/$$(basename $${FILE}); \
	done
	rmdir --ignore-fail-on-non-empty --parents $(DESTDIR)/usr/bin || true

	rmdir --ignore-fail-on-non-empty --parents $(DESTDIR)/etc/container-tools/config || true
	rmdir --ignore-fail-on-non-empty --parents $(DESTDIR)/etc/container-tools/debconf || true

clean:
	$(MAKE) -C share/man clean

distclean:

reinstall: uninstall install
