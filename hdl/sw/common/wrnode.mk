ifeq ($(CPU),lm32)
        include ../common/lm32/wrnode.mk
else
        include ../common/urv/wrnode.mk
endif