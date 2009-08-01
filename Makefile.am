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

#if SKIPMAKE
#  alltargets =
#else
  alltargets = $(libampl) stdio1.h arith.h funcadd0.$(OBJEXT)
#endif

all-local: $(alltargets)

if MSVC_COMPILE
$(libampl):
	./compile_MS_ASL
else
$(libampl):
	./compile_Unix_ASL
endif

stdio1.h arith.h funcadd0.$(OBJEXT): $(libampl)

thirdpartylibdir = $(prefix)/lib/ThirdParty
install-exec-local: $(libampl)
	test -z "$(DESTDIR)$(thirdpartylibdir)" || $(mkdir_p) "$(DESTDIR)$(thirdpartylibdir)"
	$(install_sh_DATA) $(libampl) "$(DESTDIR)$(thirdpartylibdir)/$(libampl)"

uninstall-local:
	rm -f $(DESTDIR)$(thirdpartylibdir)/$(libampl)

addlibsdir = $(prefix)/share/doc/coin/ThirdParty/ASL
addlibs_DATA = README asl_addlibs.txt

thirdpartyincludedir = $(includedir)/coin/ThirdParty
thirdpartyinclude_HEADERS = \
  solvers/asl.h solvers/asl_pfg.h solvers/asl_pfgh.h solvers/psinfo.h solvers/funcadd.h \
  solvers/nlp.h solvers/nlp2.h solvers/getstub.h solvers/opcode.hd solvers/r_opn.hd \
  stdio1.h arith.h

CLEANFILES = $(libampl) stdio1.h arith.h funcadd0.$(OBJEXT)

########################################################################
#                         Maintainer Stuff                             #
########################################################################

# Files that are generated and should be cleaned with make distclean
DISTCLEANFILES = $(MAKEOKFILE)

include ../../BuildTools/Makemain.inc
