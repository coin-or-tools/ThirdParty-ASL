# Copyright (C) 2007, 2009 International Business Machines.
# All Rights Reserved.
# This file is distributed under the Eclipse Public License.
#
# Author:  Andreas Waechter            IBM    2006-04-13
# Revised: Lou Hafer                   SFU    2007-09-15

AC_INIT([ThirdPartyASL],[2.0.0],[https://github.com/coin-or-tools/ThirdParty-ASL/issues/new],[],[https://github.com/coin-or-tools/ThirdParty-ASL])

AC_COPYRIGHT([
Copyright 2006, 2007, 2009 International Business Machines and others.
All Rights Reserved.
This file is part of the open source package ThirdParty-ASL which is distributed
under the Eclipse Public License.])

# List one file in the package so that the configure script can test
# whether the package is actually there
AC_CONFIG_SRCDIR(solvers/asl.h)

AC_COIN_INITIALIZE

# Get the name of the C compiler and compiler flags
AC_COIN_PROG_CC

# Initialize libtool
AC_COIN_PROG_LIBTOOL(no-win32-dll)

# Determine additional pre-compiler flags using various feature checks
AC_LANG_PUSH(C)

case $build in
  *-linux*)
    case $CC in
      pgcc* | */pgcc* | xlc* | */xlc* | blrts_xlc* | */blrts_xlc*)
        CPPFLAGS="$CPPFLAGS -DNO_fpu_control";;
    esac
    ;;
esac

# check whether to switch to long integers
AC_ARG_WITH([intsize],
            [AS_HELP_STRING([--with-intsize],[integer type to use: specify 32 for int or 64 for ssize_t (defines ASL_big_goff)])],
            [intsize=$withval],
            [intsize=32])
case "$intsize" in
  32 | 64 ) ;;
  *) AC_MSG_ERROR([unsupported value $intsize for option --with-intsize]) ;;
esac
AM_CONDITIONAL([ASL_INT64],[test "$intsize" = 64])

# The critical function for NO_RUSAGE is getrusage(). Use a standard test.
AC_MSG_CHECKING([for getrusage])
AC_LINK_IFELSE(
  [AC_LANG_PROGRAM([[]],[[getrusage()]])],
  [AC_MSG_RESULT([yes])],
  [CPPFLAGS="$CPPFLAGS -DNO_RUSAGE"
   AC_MSG_RESULT([no])])

# Check for long long; we need to define NO_LONG_LONG if it's not present.
# It's hardly likely that long long is missing on any modern system, but it's easy to check.
# Also, if it's present, then ASL uses strtoull, which is not supported on Windows systems.
# Instead, there should be a _strtoui64.
AC_CHECK_TYPE([long long],
  [case "$CC" in *cl ) CPPFLAGS="$CPPFLAGS -Dstrtoull=_strtoui64" ;; esac],
  [CPPFLAGS="$CPPFLAGS -DNO_LONG_LONG"])

# Check for ssize_t; we need to define NO_SSIZE_T if it's not present.
AC_CHECK_TYPE([ssize_t],[],[CPPFLAGS="$CPPFLAGS -DNO_SSIZE_T"])

# Check for dlopen, ASL uses it to load userdefined function libraries
AC_CHECK_LIB(dl,[dlopen],[ASL_LFLAGS="-ldl $ASL_LFLAGS"])

AC_COIN_CHK_LIBM(ASL)

# Back to whatever language we were in.
AC_LANG_POP(C)

case "$CC" in
  *cl )
    cc_is_cl=true
    # took this out, as with MSVS 2019 and Intel 2021 I could not reproduce an issue with ASL debug libs anymore
    #case "$CFLAGS" in *-MDd* | *-MTd* )
    #  CFLAGS=`echo $CFLAGS | sed -e 's/-MDd/-MD/g' -e 's/-MTd/-MT/g'`
    #  AC_MSG_NOTICE([ASL libraries linked with debug MSVC runtime libs do not work. Replaced -MDd and -MTd by -MD and -MT in CFLAGS, resp.])
    #  ;;
    #esac
    ;;
  * )
    cc_is_cl=false
    ;;
esac
AM_CONDITIONAL([CC_IS_CL], [$cc_is_cl])

# generate the output files.
AC_CONFIG_LINKS(stdio1.h:solvers/stdio1.h0)

# we need a second fpinit.c because we need it for a libtool lib and a non-libtool program
# and doing this for the same file isn't supported
AC_CONFIG_LINKS(fpinit.c:solvers/fpinit.c)

AC_CONFIG_FILES([Makefile coinasl.pc])

AC_COIN_FINALIZE_FLAGS([ASL])
AC_COIN_FINALIZE
