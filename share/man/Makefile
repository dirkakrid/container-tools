# Makefile

# Open Infrastructure: container-tools
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

# Depends: asciidoc dblatex docbook-xsl libxml2-utils source-highlight

A2X = a2x \
	--asciidoc-opts "-a revdate=$(shell cat ../../VERSION.txt)" \
	--doctype=manpage

SHELL := sh -e

all: build

clean:
	rm -f *.[0-9]
	rm -f *.xml

build: man

rebuild: clean build

man: *.txt
	for FILE in *.txt; \
	do \
		$(A2X) --format=manpage $${FILE}; \
	done

.PHONY: all clean build rebuild man
