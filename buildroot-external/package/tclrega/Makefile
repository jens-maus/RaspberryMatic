CXX = g++
LD = g++

CXXFLAGS = -fPIC -O2 -pipe -Wall
LDFLAGS = -shared -fPIC -ltcl8.6 -lxmlparser

all: tclrega.so

tclrega.so: tclrega.o
	$(CXX) -shared -fPIC $(LDFLAGS) -ltcl8.6 -lxmlparser -o tclrega.so tclrega.o

.cpp.o:
	$(CXX) -c $(CXXFLAGS) -fPIC $< -o $@
