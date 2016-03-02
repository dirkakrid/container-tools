# Makefile

# Depends: woff-tools

all: woff

woff: *.ttf
	for FILE in *.ttf; \
	do \
		sfnt2woff $${FILE}; \
	done

clean:
	rm -f *.woff
