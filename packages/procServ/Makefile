# Turns out to be *much* easier to rewrite the makefile from scratch than to
# persuade configure and automake to work properly for an out of tree build.

PACKAGE_STRING = "procServ Process Server $(procServ_VERSION)"
CPPFLAGS += -DPACKAGE_STRING='$(PACKAGE_STRING)'

# Configuration settings actually needed.
CPPFLAGS += -DHAVE_PTY_H
CPPFLAGS += -DHAVE_FORKPTY
CPPFLAGS += -DALLOW_FROM_ANYWHERE

CXXFLAGS += $(CFLAGS)
LDFLAGS += -lutil

CXX := $(CROSS_COMPILE)$(CXX)

SOURCES = \
    procServ.cc connectionItem.cc acceptFactory.cc clientFactory.cc \
    processFactory.cc telnetStateMachine.cc

procServ: $(SOURCES)
