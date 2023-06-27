CXX	= g++

#CXXFLAGS	= -O2 -Wall -Wno-deprecated
#CXXFLAGS	= -O2 -pipe -Wall
CXXFLAGS	= -Wall -O2 -pipe -march=armv6j -mtune=arm1176jzf-s -mfpu=vfp -mfloat-abi=hard

all: hmlangw

hmlangw:	hmlangw.o hmframe.o
	$(CXX) -o hmlangw hmlangw.o hmframe.o -lpthread
    
.cpp.o:
	$(CXX) -c $(CXXFLAGS) $<

hmlangw.o:	hmlangw.cpp hmframe.h
hmframe.o:  hmframe.cpp hmframe.h
