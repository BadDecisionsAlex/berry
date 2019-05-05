CFLAGS	    =  -Wall -Wextra -std=gnu11 -pedantic-errors -O2
LIBS	    =  -lm
TARGET	    =  lsd
CC	        =  gcc
MAKE	    =  make
MKDIR	    =  mkdir
TOUCH	    =  echo >>
MAP_BUILD	=  tools/map_build/map_build
STR_BUILD	=  tools/str_build/str_build
out         ?= build

INCPATH	 = src
SRCPATH	 = src

CFLAGS += -DUSE_READLINE_LIB
LIBS += -lreadline

ifneq ($(V), 1)
    Q=@
    MSG=@echo
else
    MSG=@true
endif

SRCS	 = $(foreach dir, $(SRCPATH), $(wildcard $(dir)/*.c))
OBJS	 = $(patsubst %.c, %.o, $(SRCS))
DEPS	 = $(patsubst %.c, %.d, $(SRCS))
INCFLAGS = $(foreach dir, $(INCPATH), -I"$(dir)")
UNCRUSTFLAGS = -c /home/camus/.uncrustify.cfg -l c -q

.PHONY : clean pretty

all: $(TARGET)

debug: CFLAGS += -O0 -g -DBE_DEBUG
debug: all

pretty:
	for f in "$(SRCS)"; do \
	  uncrustify $(UNCRUSTFLAGS) --replace $$f; \
	done

$(TARGET): generate/touch $(OBJS)
	$(MSG) [Linking...]
	$(Q) $(CC) $(OBJS) $(CFLAGS) $(LIBS) -o $@
	$(MSG) done

$(OBJS): %.o: %.c
	$(MSG) [Compile] $<
	$(Q) $(CC) -MM $(CFLAGS) $(INCFLAGS) -MT"$*.d" -MT"$(<:.c=.o)" $< > $*.d
	$(Q) $(CC) $(CFLAGS) $(INCFLAGS) -c $< -o $@

$(OBJS): $(STR_BUILD) $(MAP_BUILD)

sinclude $(DEPS)

generate/touch: $(STR_BUILD) $(MAP_BUILD) generate $(SRCS)
	$(MSG) [Prebuild] generate resources
	$(Q) $(MAP_BUILD) $(SRCS) generate
	$(Q) $(STR_BUILD) $(SRCS) generate
	$(Q) $(TOUCH) generate/touch

generate:
	$(Q) $(MKDIR) generate

$(STR_BUILD):
	$(MSG) [Make] str_build
	$(Q) $(MAKE) -C tools/str_build -s

$(MAP_BUILD):
	$(MSG) [Make] map_build
	$(Q) $(MAKE) -C tools/map_build -s

install:
	$(MKDIR) -p ${out}/bin
	cp $(TARGET) ${out}/bin/$(TARGET)

uninstall:
	$(RM) /usr/local/bin/$(TARGET)

prebuild: $(STR_BUILD) $(MAP_BUILD) generate
	$(MSG) [Prebuild] generate resources
	$(Q) $(MAP_BUILD) $(SRCS) generate
	$(Q) $(STR_BUILD) $(SRCS) generate
	$(MSG) done

clean:
	$(MSG) [Clean...]
	$(Q) $(RM) $(OBJS) $(DEPS)
	$(Q) $(RM) generate/*
	$(MSG) done
