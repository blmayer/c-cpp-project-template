# Make file for the <PROJECT> project.
# Currently we are compiling some  object files (.o) from header files (.h), 
# which are then linked to create the final binary.

SHELL := /bin/bash
OBJS := # put a list of objects to be built preceded by obj

# do some system checks
ifeq ($(OS),Windows_NT)
	TARGET = # name of the binary.exe
	ARCH = Windows_NT
else 
	ARCH = $(shell uname -s)
	TARGET = # name of the target
	ifeq ($(ARCH),Darwin)
		CFLAGS = # flags passed to the compiler, please include -Wall for C/C++
		LFLAGS = # flags passed to the linker
		LIBDIR = /usr/local/lib
		INCDIR = /usr/local/include
	else
		CFLAGS = # flags passed to the compiler, please include -Wall for C/C++
		LFLAGS = # flags passed to the linker
		LIBDIR = /usr/lib
		INCDIR = /usr/include
	endif
endif

# set directories for search dependencies
vpath %.h 	include
vpath %.c 	src
vpath %.so 	lib

# targets
.PHONY: $(TARGET) clean distclean

# link
$(TARGET): $(OBJS)
	@if test ! -d bin/$(ARCH); then mkdir bin/$(ARCH); fi
	@echo "Now objects will be linked."
	$(CC) $^ $(CFLAGS) -o bin/$(ARCH)/$@ $(LFLAGS)
	@echo "Done."

# compile
obj/%.o: %.c
	@if test ! -d obj; then mkdir obj; fi
	@echo "Compiling $<..."
	$(CC) $(CFLAGS) -c $< -o $@
	
# remove compilation products
clean:
	@echo "Cleaning up..."
	$(RM) obj/*.o

# remove compilation and linking products
distclean:
	@echo "Cleaning up..."
	$(RM) obj/*.o
	$(RM) -rf bin/*

