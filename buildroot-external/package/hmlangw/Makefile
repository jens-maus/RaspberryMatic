#CC	= gcc-4.6
CC	= gcc

#CFLAGS	= -O2 -Wall -Wno-deprecated
#CFLAGS	= -O2 -pipe -Wall
CFLAGS	= -Wall -O2 -pipe -march=armv6j -mtune=arm1176jzf-s -mfpu=vfp -mfloat-abi=hard

all: hmlangw


hmlangw:	hmlangw.o hmframe.o
	$(CC) -o hmlangw hmlangw.o hmframe.o -lpthread
    
#	$(CC) -o hmlangw hmlangw.o hmframe.o -lutil -lpthread -lrt -lm -lstdc++

.cpp.o:
	$(CC) -c $(CFLAGS) $<

.c.o:
	$(CC) -c $(CFLAGS) $<

   
# DO NOT DELETE

hmlangw.o:	hmlangw.cpp hmframe.h
hmframe.o:  hmframe.cpp hmframe.h

