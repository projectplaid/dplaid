SRC_FOLDERS=source

.PHONY: all clean run

all:
	make -C source all

clean:
	make -C source clean

run:
	make -C source run