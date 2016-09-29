# and don't touch the rest unless you know what you're doing.
CROSS_COMPILE ?= /opt/gcc-lm32/bin/lm32-elf-

CC =		$(CROSS_COMPILE)gcc
LD =		$(CROSS_COMPILE)ld
OBJDUMP =	$(CROSS_COMPILE)objdump
OBJCOPY =	$(CROSS_COMPILE)objcopy
SIZE =		$(CROSS_COMPILE)size

CFLAGS = -DWRNODE_RT -g -O3 -I. -I../common -I../../include -I../include/ -mmultiply-enabled -mbarrel-shift-enabled -ffunction-sections -fdata-sections -Wl,--gc-sections
OBJS += ../common/wrn-crt0.o  ../common/rt-common.o  ../common/printf.o ../common/vsprintf-xint.o
LDSCRIPT = ../common/wrnode.ld

$(OUTPUT): $(LDSCRIPT) $(OBJS)
	${CC} -o $(OUTPUT).elf -nostartfiles $(OBJS) -T $(LDSCRIPT) -lgcc -lc -Wl,--gc-sections
	${OBJCOPY} --remove-section .smem -O binary $(OUTPUT).elf $(OUTPUT).bin
	${OBJDUMP} -S $(OUTPUT).elf  > disasm.S
	../common/genraminit $(OUTPUT).bin > $(OUTPUT).ram
	$(SIZE) $(OUTPUT).elf

clean:
	rm -f $(OBJS) $(OUTPUT).bin
	
install:
	cp $(OUTPUT).bin /acc/local/share/firmware/list