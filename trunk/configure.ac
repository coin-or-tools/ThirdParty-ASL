# Copyright (C) 2006 International Business Machines.
# All Rights Reserved.
# This file is distributed under the Common Public License.

## $Id$

# Author:  Andreas Waechter            IBM    2006-04-13

#############################################################################
#                       Names and other basic things                        #
#############################################################################

AC_PREREQ(2.59)

AC_INIT([ThirdPartyASL],[1.0trunk],[http://projects.coin-or.org/BuildTools/newticket])

AC_COPYRIGHT([
Copyright 2006 International Business Machines and others.
All Rights Reserved.
This file is part of the open source package Coin which is distributed
under the Common Public License.])

# List one file in the package so that the configure script can test
# whether the package is actually there
AC_CONFIG_SRCDIR(solvers/asl.h)

# Where should everything be installed by default?  Here, we want it
# to be installed directly in 'bin', 'lib', 'include' subdirectories
# of the directory where configure is run.  The default would be
# /usr/local.
AC_PREFIX_DEFAULT([`pwd`])

AC_COIN_PROJECTDIR_INIT

#############################################################################
#                         Standard build tool stuff                         #
#############################################################################

# Get the system type
AC_CANONICAL_BUILD

#turn off warnings and pedantic mode since they could make trouble on some platforms,
#and we couldn't fix them anyway
coin_skip_warn_cflags=yes

# Check if user wants to produce debugging code
AC_COIN_DEBUG_COMPILE(ASL)

# We need egrep and ln -s somewhere
AC_PROG_EGREP
AC_PROG_LN_S

# Get the name of the C compiler and appropriate compiler options
coin_skip_warn_cflags=yes
AC_COIN_PROG_CC

# Initialize automake
AC_COIN_INIT_AUTOMAKE

AC_COIN_HAS_ASL
MAKEOKFILE=.MakeOk
if test $coin_has_asl != no && test "$use_asldir" != BUILD; then
  skip_further_test=yes
  rm -f $MAKEOKFILE
  AC_MSG_NOTICE([The ASL sources don't need to be compiled])
  MAKEOKFILE=
else
  touch $MAKEOKFILE
fi
AC_SUBST(MAKEOKFILE)
AM_CONDITIONAL(SKIPMAKE, test -z "$MAKEOKFILE")

#############################################################################
#                          AMPL SOLVER LIBRARY                              #
#############################################################################

if test x$skip_further_test != xyes; then

  # Determine the name of the ASL library
  AC_SUBST(AMPLSOLVER_A)
  case "$CC" in
    cl* | */cl* | CL* | */CL*)
      AMPLSOLVER_A=amplsolv.lib
      msvc_compile=yes ;;
    *)
      AMPLSOLVER_A=amplsolver.a
      msvc_compile=no ;;
  esac

  if test -z "$ASLMAKEFLAGS" ; then
    asladdcflags=
    case $build in
      *-linux*)
        asladdcflags="-DNON_STDIO"
        case $CC in
          pgcc* | */pgcc* | xlc* | */xlc* | blrts_xlc* | */blrts_xlc*)
            asladdcflags="$asladdcflags -DNO_fpu_control";;
        esac
        ;;
      *-cygwin*) # ToDo: If on Cygwin but not using -mno-cygwin, we should not define -DNo_Control87 -DNO_RUSAGE
        asladdcflags="-DNON_STDIO -DNo_Control87 -DNO_RUSAGE"
        ;;
      *-mingw32)
        asladdcflags="-DNON_STDIO -DNo_Control87 -DNO_RUSAGE"
        ;;
    esac

# On BlueGene disable dynamic library loading
    if test x"$enable_bg" = xyes; then
      asladdcflags="$asladdcflags -DNO_FUNCADD"
    fi

# Do the following for now to make sure we are not interupting compilation
# of ASL because of warning message:
    bla=
    for i in $CFLAGS; do
      if test "$i" != "-Werror"; then
        bla="$bla $i"
      fi
    done
    ASLMAKEFLAGS="CFLAGS=\"$bla $asladdcflags\""

#   Somehow, -qtune=auto makes ASL segfault on AIX compiler, so take them out
    case $CC in
      xlc* | */xlc* | mpxlc* | */mpxlc*)
        ASLMAKEFLAGS=`echo $ASLMAKEFLAGS | sed -e 's/-qtune=auto//g' -e 's/-qarch=auto//g' -e 's/-qcache=auto//g' -e 's/-qhot//g' -e sed 's/-O3/-O/g'`
        ;;
      pgcc* | */pgcc*)
        ASLMAKEFLAGS=`echo $ASLMAKEFLAGS | sed 's/-fast/-O1/g'`
        ;;
    esac

    AC_MSG_CHECKING([whether $am_make is the GNU make])
    rm -rf conftest.mak
    ($am_make -v -f conftest.mak > conftest.grp) 2>&5
    if $EGREP GNU conftest.grp >&5 ; then
      AC_MSG_RESULT([yes])
      ASLMAKEFLAGS="-j 1 $ASLMAKEFLAGS"
    else
      AC_MSG_RESULT([no])
    fi
    rm -f conftest.mak conftest.grp
  fi

  if test x"$AR" = x; then
    AR=ar
  fi

  ASLMAKEFILECMDS="sed -e 's%ar \$\$(ARFLAGS)%$AR \$\$(ARFLAGS)%' makefile.u | sed -e 's%ar ruv%$AR ruv%' "
  if test "$EXEEXT" = ".exe"; then
    ASLMAKEFILECMDS="$ASLMAKEFILECMDS | sed 's/a.out/a.exe/'"
  fi
  case $build in
    *-cygwin*)
      ASLMAKEFILECMDS="$ASLMAKEFILECMDS | sed 's%s/System_details/\`uname -sr\`/%s|System_details|\`uname -sr\`|%'" ;;
  esac
  ASLMAKEFILECMDS="$ASLMAKEFILECMDS > makefile"

  AC_ARG_VAR(ASLMAKEFLAGS,[Compilation flags necessary for compiling the AMPL solver library])
  AC_SUBST(ASLMAKEFILECMDS)

fi

AM_CONDITIONAL(MSVC_COMPILE, test x$msvc_compile = xyes)

AC_CONFIG_FILES([Makefile compile_MS_ASL])

AC_COIN_FINALIZE

# Finally, we need to make sure that compile_MS_ASL is executable
chmod a+x compile_MS_ASL
