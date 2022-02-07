CXX = g++
LD = g++

CXXFLAGS = -fPIC -O2 -pipe -Wall
LDFLAGS = -shared -fPIC

all: tclrega.so

tclrega.so: tclrega.o
	$(CXX) -shared -fPIC $(LDFLAGS) -o tclrega.so tclrega.o

.cpp.o:
	$(CXX) -c $(CXXFLAGS) -fPIC $< -o $@
