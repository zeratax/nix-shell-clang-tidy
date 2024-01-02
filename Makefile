# Compiler and flags
CXX = clang++
CXXWARNINGS = -Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic
CXXFLAGS = $(CWARNINGS) -std=c++20 -g -O2

# Include and library paths
INCLUDES = -I$(SYSTEMC_HOME)/include
LIBS = -L$(SYSTEMC_HOME)/lib -lsystemc

# Source files
SRCS = test.cpp

# Object files
OBJS = $(SRCS:.cpp=.o)

# Executable name
TARGET = test 

# Build rules
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ $(OBJS) $(LIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)

