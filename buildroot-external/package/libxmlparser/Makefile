CXX = g++
LD = g++
AR = ar
STRIP = strip

SRC = ./src

CXXFLAGS = -fPIC -O2 -pipe -Wall
LDFLAGS = -shared -fPIC

OBJ = xmlParser.o

LIB = libxmlparser.a
SOLIB = libxmlparser.so

all: $(LIB) $(SOLIB)

$(LIB) : $(OBJ)
	$(AR) $(ARFLAGS) $(LIB) $(OBJ)

$(SOLIB): $(OBJ)
	$(CXX) -shared -fPIC $(LDFLAGS) -o $(SOLIB) $(OBJ)
	cp -f $(SOLIB) $(SOLIB).debug || true
	$(STRIP) $(SOLIB)

.cpp.o:
	$(CXX) -c $(CXXFLAGS) -fPIC $< -o $@
