# Copyright (C) 2019 COIN-OR
# All Rights Reserved.
# This file is distributed under the Eclipse Public License.

AUTOMAKE_OPTIONS = foreign subdir-objects

EXTRA_DIST = get.ASL INSTALL.ASL

lib_LTLIBRARIES = libcoinasl.la

libcoinasl_la_SOURCES = \
	solvers/asldate.c \
	solvers/atof.c \
	solvers/auxinfo.c \
	solvers/avltree.c \
	solvers/b_search.c \
	solvers/basename.c \
	solvers/bscanf.c \
	solvers/com2eval.c \
	solvers/comeval.c \
	solvers/con1ival.c \
	solvers/con2ival.c \
	solvers/con2val.c \
	solvers/conadj.c \
	solvers/conpval.c \
	solvers/conscale.c \
	solvers/conval.c \
	solvers/degree.c \
	solvers/derprop.c \
	solvers/duthes.c \
	solvers/dtoa1.c \
	solvers/dynlink.c \
	solvers/f_read.c \
	solvers/fg_read.c \
	solvers/fg_write.c \
	solvers/fgh_read.c \
	solvers/fpecatch.c \
	solvers/fullhes.c \
	solvers/func_add.c \
	solvers/funcadd1.c \
	solvers/g_fmt.c \
	solvers/genrowno.c \
	solvers/getenv.c \
	solvers/getstub.c \
	solvers/htcl.c \
	solvers/indic_cons.c \
	solvers/jac0dim.c \
	solvers/jac2dim.c \
	solvers/jacdim.c \
	solvers/jacinc.c \
	solvers/jacinc1.c \
	solvers/libnamsave.c \
	solvers/mach.c \
	solvers/mainexit.c \
	solvers/mip_pri.c \
	solvers/misc.c \
	solvers/mpec_adj.c \
	solvers/mqpcheckv.c \
	solvers/mypow.c \
	solvers/names.c \
	solvers/nl_obj.c \
	solvers/nqpcheck.c \
	solvers/nqpcheckZ.c \
	solvers/obj2val.c \
	solvers/obj_adj.c \
	solvers/obj_prec.c \
	solvers/objconst.c \
	solvers/objval.c \
	solvers/objval_.c \
	solvers/op_type.c \
	solvers/pfg_read.c \
	solvers/pfghread.c \
	solvers/printf.c \
	solvers/pshvprod.c \
	solvers/punknown.c \
	solvers/qp_read.c \
	solvers/qpcheck.c \
	solvers/qpcheckZ.c \
	solvers/qsortv.c \
	solvers/readsol.c \
	solvers/repwhere.c \
	solvers/rops.c \
	solvers/rops2.c \
	solvers/sigcatch.c \
	solvers/sos_add.c \
	solvers/sphes.c \
	solvers/sscanf.c \
	solvers/stderr.c \
	solvers/studchk0.c \
	solvers/suf_sos.c \
	solvers/value.c \
	solvers/writesol.c \
	solvers/wrtsol_.c \
	solvers/ws_desc.c \
	solvers/wsu_desc.c \
	solvers/x2check.c \
	solvers/xectim.c \
	solvers/xp1known.c \
	solvers/xp2known.c \
	details.c \
	arith.h

if CC_IS_CL
  libcoinasl_la_SOURCES += solvers/fpinitmt.c
else
  libcoinasl_la_SOURCES += solvers/fpinit.c
endif

libcoinasl_la_LIBADD = $(ASL_LFLAGS)

# This is for libtool
libcoinasl_la_LDFLAGS = $(LT_LDFLAGS)

# make sure that arith.h is build before any of the actual ASL sources
BUILT_SOURCES = arith.h

# program that generates arith.h
# NOTE: current ASL provides an alternative that doesn't require
#  building and executing something first
noinst_PROGRAMS = arithchk
arithchk_SOURCES = solvers/arithchk.c
if CC_IS_CL
  arithchk_CPPFLAGS = -DNO_FPINIT
else
  arithchk_CPPFLAGS = -DASL_NO_FPINITMT
  arithchk_SOURCES += fpinit.c
endif
arithchk_LDADD = $(ASL_LFLAGS)

arith.h : arithchk$(EXEEXT)
	./arithchk$(EXEEXT) > $@

details.c :
	echo "char sysdetails_ASL[] = \"$(build)\";" > $@

# Suppress default defines from autoheader
DEFS =

########################################################################
#                           Extra Targets                              #
########################################################################

test:
	@echo "No test available for ASL."

thirdpartyincludedir = $(includedir)/coin-or/asl
thirdpartyinclude_HEADERS = \
  solvers/asl.h solvers/asl_pfg.h solvers/asl_pfgh.h solvers/psinfo.h solvers/funcadd.h \
  solvers/nlp.h solvers/nlp2.h solvers/getstub.h solvers/opcode.hd solvers/r_opn.hd \
  stdio1.h arith.h

pkgconfiglibdir = $(libdir)/pkgconfig
pkgconfiglib_DATA = coinasl.pc

CLEANFILES = arith.h details.c

########################################################################
#                         Maintainer Stuff                             #
########################################################################

# Files that are generated and should be cleaned with make distclean
DISTCLEANFILES =
