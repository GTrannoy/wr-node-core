# and don't touch the rest unless you know what you're doing.
CROSS_COMPILE ?= /opt/gcc-riscv-5.2.0/bin/riscv64-unknown-elf-

CC =		$(CROSS_COMPILE)gcc
LD =		$(CROSS_COMPILE)ld
OBJDUMP =	$(CROSS_COMPILE)objdump
OBJCOPY =	$(CROSS_COMPILE)objcopy
SIZE =		$(CROSS_COMPILE)size

CFLAGS = -DWRNODE_RT -g -O2 -m32 -flto -I. -I../common -I../../include -I../include/ -march=RV32IM
OBJS += ../common/urv/crt0.o ../common/urv/irq.o ../common/urv/emulate.o ../common/rt-common.o  ../common/printf.o ../common/vsprintf-xint.o
LDSCRIPT = ../common/urv/wrnode.ld

$(OUTPUT): $(LDSCRIPT) $(OBJS)
	${CC} -m32 -flto -g -o  $(OUTPUT).elf -nostartfiles $(OBJS) -T $(LDSCRIPT) -lgcc -lc
	${OBJCOPY} --remove-section .smem -O binary $(OUTPUT).elf $(OUTPUT).bin
	${OBJDUMP} -S $(OUTPUT).elf  > disasm.S
	../common/genraminit $(OUTPUT).bin > $(OUTPUT).ram
	$(SIZE) $(OUTPUT).elf

../common/urv/emulate.o:	../common/urv/emulate.c
	${CC} -O2 -m32 -march=RV32I -m32 -c $^ -o $@ -I.

%.o:	%.S
	${CC} -march=RV32I -m32 -c $^ -o $@

clean:
	rm -f $(OBJS) $(OUTPUT).bin
	
install:
	cp $(OUTPUT).bin /acc/local/share/firmware/list