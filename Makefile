SRC_FOLDERS=source

.PHONY: all clean

all:
	make -C source all

clean:
	make -C source clean
