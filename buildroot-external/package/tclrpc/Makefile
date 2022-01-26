CXX = g++
LD = g++

CXXFLAGS = -fPIC -O2 -pipe -Wall
LDFLAGS = -shared -fPIC

all: tclrpc.so

tclrpc.so: tclrpc.o
	$(CXX) -shared -fPIC $(LDFLAGS) -o tclrpc.so tclrpc.o

.cpp.o:
	$(CXX) -c $(CXXFLAGS) -fPIC $< -o $@
