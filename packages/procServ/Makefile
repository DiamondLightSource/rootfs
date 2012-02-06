# Make file for procServ.  It's too hard to configure, but actually the build
# ought to be really easy.

CC := $(CROSS_COMPILE)$(CC)
CXX := $(CROSS_COMPILE)$(CXX)

SOURCES = \
    procServ.cc connectionItem.cc acceptFactory.cc clientFactory.cc \
    processFactory.cc telnetStateMachine.cc

procServ: $(SOURCES)
