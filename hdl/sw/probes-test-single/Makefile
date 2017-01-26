OBJS = probes1.o
OUTPUT = probes1
EXTRA_TARGETS = probes_file

include ../common/wrnode.mk

probes_file:	$(OUTPUT).elf
	./extract-probes.py $(OUTPUT).elf > probes.dat
