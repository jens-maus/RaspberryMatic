CXX = g++
LD = g++

CXXFLAGS = -fPIC -O2 -pipe -Wall
LDFLAGS = -shared -fPIC -ltcl8.6 -lXmlRpc

all: tclrpc.so

tclrpc.so: tclrpc.o
	$(CXX) -shared -fPIC $(LDFLAGS) -ltcl8.6 -lXmlRpc -o tclrpc.so tclrpc.o

.cpp.o:
	$(CXX) -c $(CXXFLAGS) -fPIC $< -o $@
