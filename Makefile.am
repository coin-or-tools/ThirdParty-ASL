# Copyright (C) 2003, 2007 International Business Machines and others.
# All Rights Reserved.
# This file is distributed under the Common Public License.

## $Id: Makefile.am 735 2006-06-04 06:10:05Z andreasw $

AUTOMAKE_OPTIONS = foreign

EXTRA_DIST = get.ASL INSTALL.ASL

########################################################################
#                           Extra Targets                              #
########################################################################

compdir = compdir

libampl   = $(AMPLSOLVER_A)

if SKIPMAKE
  alltargets =
else
  alltargets = $(libampl) stdio1.h arith.h funcadd0.$(OBJEXT)
endif

all-local: $(alltargets)

if MSVC_COMPILE
$(libampl):
	compile_MS_ASL
else
$(libampl):
	rm -rf $(compdir) ; \
	$(mkinstalldirs) $(compdir); \
	files=`cd $(abs_source_dir)/solvers; ls *.[chs] *.[ch]0 *.hd arith.* makefile* `; \
	cd $(compdir); \
	for file in $$files; \
	do \
	  rm -f $$file ;\
	  $(LN_S) $(abs_source_dir)/solvers/$$file $$file ;\
	done; \
	rm -f makefile; \
	$(ASLMAKEFILECMDS); \
	$(MAKE) $(ASLMAKEFLAGS) CC="$(CC)" clean ;\
	$(MAKE) $(ASLMAKEFLAGS) CC="$(CC)" ;\
	mv amplsolver.a ../$(libampl)
	-cd $(compdir); mv stdio1.h arith.h funcadd0.$(OBJEXT) ..
	rm -rf $(compdir)
endif

stdio1.h arith.h funcadd0.$(OBJEXT): $(libampl)

CLEANFILES = $(libampl) stdio1.h arith.h funcadd0.$(OBJEXT)

########################################################################
#                         Maintainer Stuff                             #
########################################################################

# Files that are generated and should be cleaned with make distclean
DISTCLEANFILES = $(MAKEOKFILE)

include ../../BuildTools/Makemain.inc
