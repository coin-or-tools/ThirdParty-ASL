# Copyright (C) 2003, 2006 International Business Machines and others.
# All Rights Reserved.
# This file is distributed under the Common Public License.

## $Id: Makefile.am 735 2006-06-04 06:10:05Z andreasw $

AUTOMAKE_OPTIONS = foreign

EXTRA_DIST = get.ASL INSTALL.ASL

compdir = compdir

libampl   = amplsolver.a

all-local: $(libampl) stdio1.h arith.h funcadd0.o

$(libampl):
	rm -rf $(compdir) ; \
	$(mkinstalldirs) $(compdir); \
	files=`cd $(abs_source_dir)/solvers; ls *.[chs] *.[ch]0 *.hd arith.* makefile* `; \
	cd $(compdir); \
	for file in $$files; \
	do \
	  $(LN_S) $(abs_source_dir)/solvers/$$file $$file ;\
	done; \
	rm -f makefile; \
	$(ASLMAKEFILECMDS); \
	$(MAKE) $(ASLMAKEFLAGS) CC="$(CC)" clean ;\
	$(MAKE) $(ASLMAKEFLAGS) CC="$(CC)" ;\
	mv amplsolver.a ../$(libampl)
	-cd $(compdir); mv stdio1.h arith.h funcadd0.o ..
	rm -rf $(compdir)

stdio1.h arith.h funcadd0.o: $(libampl)

CLEANFILES = $(libampl) stdio1.h arith.h funcadd0.o

# ASLsolvers

distclean-local:
	rm -rf ASLsolvers
