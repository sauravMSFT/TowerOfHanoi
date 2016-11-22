OUTDIR = out
ifeq ($(OS),Windows_NT)
	INCLUDE     = -Iinclude -I"F:/MiniProjects/TowerOfHanoi/include"
	LIBS        = -L"C:/Program Files (x86)/Dev-Cpp/MinGW32/lib" -static-libstdc++ -static-libgcc "C:/Program Files (x86)/Dev-Cpp/MinGW32/lib/libopengl32.a" "C:/Program Files (x86)/Dev-Cpp/MinGW32/lib/libglu32.a" "C:/Program Files (x86)/Dev-Cpp/MinGW32/lib/libglut32.a"
	CFLAGS      = $(INCLUDE) -lglu32 -lglut32 -lopengl32 -lm 
	BIN         = $(OUTDIR)/toh.exe
else
	BIN         = $(OUTDIR)/toh.out
	INCLUDE     = -Iinclude
	CFLAGS      = $(INCLUDE) -lGL -lGLU -lglut -lm
endif

LIBSRC          = $(wildcard lib/*.c)
LIB             = $(LIBSRC:.c=.o)
MODELSRC        = $(wildcard src/model/*.c)
MODEL           = $(MODELSRC:.c=.o)
VIEWSRC        = $(wildcard src/view/*.c)
VIEW           = $(VIEWSRC:.c=.o)
VIEWMODELSRC    = $(wildcard src/viewmodel/*.c)
VIEWMODEL       = $(VIEWMODELSRC:.c=.o)
MODULES         = $(OUTDIR)/*.o

all: clean $(BIN) cleano 

$(BIN): $(LIB) $(MODEL) $(VIEW) $(VIEWMODEL)
	gcc -g $(INCLUDE) src/main.c $(MODULES) -o $(BIN) $(CFLAGS) $(LIBS)

%.o: %.c
	gcc -g -c $^ $(CFLAGS) -o out/$(basename $(<F)).o --std=c99

stringopstest:
	gcc -g -Iinclude lib/stringops.c tests/stringopstest.c -o out/tests/stringopstest.out

clean:
	rm $(OUTDIR) -r
	mkdir out

cleano:
	rm $(OUTDIR)/*.o -rf
	rm $(OUTDIR)/.f* -rf
	rm $(OUTDIR)/tests/.f* -rf