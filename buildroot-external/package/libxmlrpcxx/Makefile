CXX = g++
LD = g++
AR = ar
STRIP = strip

SRC = ./src

CXXFLAGS = -fPIC -O2 -pipe -Wall
LDFLAGS = -shared -fPIC

OBJ = $(SRC)/XmlRpcClient.o $(SRC)/XmlRpcDispatch.o \
      $(SRC)/XmlRpcServer.o $(SRC)/XmlRpcServerProxy.o $(SRC)/XmlRpcServerConnection.o \
      $(SRC)/XmlRpcServerMethod.o $(SRC)/XmlRpcSocket.o $(SRC)/XmlRpcSource.o \
      $(SRC)/XmlRpcUtil.o $(SRC)/XmlRpcValue.o

LIB = libXmlRpc.a
SOLIB = libXmlRpc.so

all: $(LIB) $(SOLIB)

$(LIB) : $(OBJ)
	$(AR) $(ARFLAGS) $(LIB) $(OBJ)

$(SOLIB): $(OBJ)
	$(CXX) -shared -fPIC $(LDFLAGS) -o $(SOLIB) $(OBJ)
	cp -f $(SOLIB) $(SOLIB).debug || true
	$(STRIP) $(SOLIB)

.cpp.o:
	$(CXX) -c $(CXXFLAGS) -fPIC $< -o $@
