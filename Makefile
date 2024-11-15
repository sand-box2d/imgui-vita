TARGET		:= libimgui

CPPSOURCES	:= .

CFILES	:= 
CPPFILES   := $(foreach dir,$(CPPSOURCES), $(wildcard $(dir)/*.cpp))
BINFILES := $(foreach dir,$(DATA), $(wildcard $(dir)/*.bin))
OBJS     := $(addsuffix .o,$(BINFILES)) $(CFILES:.c=.o) $(CPPFILES:.cpp=.o)

PREFIX  = arm-vita-eabi
CC      = $(PREFIX)-gcc
CXX      = $(PREFIX)-g++
CFLAGS  = -Wl,-q -O2 -g -mtune=cortex-a9 -mfpu=neon -ftree-vectorize
CXXFLAGS  = $(CFLAGS) -fno-exceptions -std=gnu++17 -fpermissive
ASFLAGS = $(CFLAGS)
AR      = $(PREFIX)-gcc-ar

all: $(TARGET).a

$(TARGET).a: $(OBJS)
	$(AR) -rc $@ $^

install: $(TARGET).a
	@mkdir -p $(VITASDK)/$(PREFIX)/lib/
	cp $(TARGET).a $(VITASDK)/$(PREFIX)/lib/
	@mkdir -p $(VITASDK)/$(PREFIX)/include/
	cp *.h $(VITASDK)/$(PREFIX)/include/

clean:
	@rm -rf $(TARGET).a $(TARGET).elf $(OBJS)
