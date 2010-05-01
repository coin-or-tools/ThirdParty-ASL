# Copyright (C) 2003, 2007 International Business Machines and others.
# All Rights Reserved.
# This file is distributed under the Common Public License.

## $Id$

AUTOMAKE_OPTIONS = foreign

EXTRA_DIST = get.ASL INSTALL.ASL

########################################################################
#                           Extra Targets                              #
########################################################################

compdir = compdir

libampl   = $(AMPLSOLVER_A)

alltargets = $(libampl) stdio1.h arith.h funcadd0.$(OBJEXT)

all-local: $(alltargets)

if MSVC_COMPILE
$(libampl):
	./compile_MS_ASL
else
$(libampl):
	./compile_Unix_ASL
endif

stdio1.h arith.h funcadd0.$(OBJEXT): $(libampl)

thirdpartyincludedir = $(includedir)/coin/ThirdParty
thirdpartyinclude_HEADERS = \
  solvers/asl.h solvers/asl_pfg.h solvers/asl_pfgh.h solvers/psinfo.h solvers/funcadd.h \
  solvers/nlp.h solvers/nlp2.h solvers/getstub.h solvers/opcode.hd solvers/r_opn.hd \
  stdio1.h arith.h

thirdpartylibdir = $(libdir)/coin/ThirdParty
thirdpartylib_DATA = $(libampl)

if COIN_HAS_PKGCONFIG
addlibsdir = $(datadir)/coin/doc/ThirdParty/ASL
addlibs_DATA = asl_addlibs.txt

asl_addlibs.txt : coinasl.pc
	PKG_CONFIG_PATH=.:@COIN_PKG_CONFIG_PATH@ $(PKG_CONFIG) --libs coinasl > asl_addlibs.txt
endif

pkgconfiglibdir = $(libdir)/pkgconfig
pkgconfiglib_DATA = coinasl.pc

CLEANFILES = $(libampl) stdio1.h arith.h funcadd0.$(OBJEXT) asl_addlibs.txt

########################################################################
#                         Maintainer Stuff                             #
########################################################################

# Files that are generated and should be cleaned with make distclean
DISTCLEANFILES = $(MAKEOKFILE)

include ../../BuildTools/Makemain.inc
