# Copyright (C) 2003, 2007 International Business Machines and others.
# All Rights Reserved.
# This file is distributed under the Eclipse Public License.

## $Id$

# the idea is to use the ASL Makefiles to build a static $(AMPLSOLVER_A) library via the compile_*_ASL scripts
# from this library, we create a libcoinasl.la libtool library
# in a MS VC build, we assume static libraries are used, so we can use the usual libtool machinery via LIBADD
# in a normal build, we build the libcoinasl.la library by extracting the $(AMPLSOLVER_A) library and relinking it via libtool
#    in a shared library build, this should give a shared libcoinasl.so library
#    further, configure should have taken care of adding -fPIC -DPIC to the CFLAGS when compiling the ASL sources

AUTOMAKE_OPTIONS = foreign

EXTRA_DIST = get.ASL INSTALL.ASL

if COIN_CC_IS_CL
lib_LTLIBRARIES = libcoinasl.la

libcoinasl_la_SOURCES = 
libcoinasl_la_LIBADD = $(AMPLSOLVER_A)

# This is for libtool
libcoinasl_la_LDFLAGS = $(LT_LDFLAGS)
endif

########################################################################
#                           Extra Targets                              #
########################################################################

compdir = compdir

alltargets = stdio1.h arith.h funcadd0.$(OBJEXT)

if COIN_CC_IS_CL
$(AMPLSOLVER_A):
	./compile_MS_ASL
	
else
$(AMPLSOLVER_A):
	./compile_Unix_ASL

libcoinasl.la : $(AMPLSOLVER_A)
	mkdir tmp ; cd tmp ; $(AR) x ../$(AMPLSOLVER_A) ; cd ..
	$(LIBTOOL) --tag=CC --mode=link $(CC) $(AM_CFLAGS) $(CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -o $@ -rpath $(libdir) $(LT_LDFLAGS) tmp/*.o
	rm -rf tmp

alltargets += libcoinasl.la

thirdpartylibdir = $(libdir)
thirdpartylib_DATA = libcoinasl.la
endif

stdio1.h arith.h funcadd0.$(OBJEXT): $(AMPLSOLVER_A)

all-local: $(alltargets)

test:
	@echo "No test available for ASL."

thirdpartyincludedir = $(includedir)/coin/ThirdParty
thirdpartyinclude_HEADERS = \
  solvers/asl.h solvers/asl_pfg.h solvers/asl_pfgh.h solvers/psinfo.h solvers/funcadd.h \
  solvers/nlp.h solvers/nlp2.h solvers/getstub.h solvers/opcode.hd solvers/r_opn.hd \
  stdio1.h arith.h

pkgconfiglibdir = $(libdir)/pkgconfig
pkgconfiglib_DATA = coinasl.pc

CLEANFILES = $(AMPLSOLVER_A) $(alltargets)

########################################################################
#                         Maintainer Stuff                             #
########################################################################

# Files that are generated and should be cleaned with make distclean
DISTCLEANFILES =

include BuildTools/Makemain.inc
