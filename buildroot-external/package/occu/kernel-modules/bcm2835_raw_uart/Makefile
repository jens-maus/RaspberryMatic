ifeq ($(CONFIG_ARCH_BCM2835),y)
  obj-m += bcm2835_raw_uart.o
endif

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
 
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
