#!/bin/sh

set -e

wgetcmd="wget"
wgetcount=`which wget 2>/dev/null | wc -l`
if test ! $wgetcount = 1; then
  echo "Utility wget not found in your PATH."
  if test `uname` = Darwin; then
    wgetcmd="curl -L -k -O"
    echo "Using ftp command instead."
  elif test `uname` = FreeBSD; then
    wgetcmd=fetch
    echo "Using fetch command instead."
  else
    exit -1
  fi
fi

coinasl=solvers-20130815.tar

echo " "
echo "Running script for downloading the source code for the ASL"
echo " "

rm -f solvers.tar

echo "Downloading the source code from projects.coin-or.org..."
if $wgetcmd https://projects.coin-or.org/svn/BuildTools/ThirdParty/ASL/src/$coinasl ;
then
  mv $coinasl solvers.tar
else
  echo
  tryamplcom=1
  if test "$wgetcmd" = wget ;
  then
    # the ASL tarball on ampl.com is changing over time, so we give the coin-or server another chance first
    echo -n "Failed, try downloading from https://projects.coin-or.org without certificate check? (y/n) "
    if test "$1" = "-y" ;
    then
      doit=y
      echo y
    else
      read doit
      echo
    fi
    if test "$doit" = y ;
    then
      if $wgetcmd --no-check-certificate https://projects.coin-or.org/svn/BuildTools/ThirdParty/ASL/src/$coinasl ;
      then
        mv $coinasl solvers.tar
        tryamplcom=0
      fi
    fi
  fi
  if test $tryamplcom = 1 ;
  then
    echo
    echo "Failed, try downloading the source code from www.ampl.com..."
    $wgetcmd http://www.ampl.com/netlib/ampl/solvers.tgz ;
    gunzip solvers.tgz
  fi
fi

rm -rf solvers

echo "Unpacking the source code..."
tar xf solvers.tar

echo "Uncompressing the source files..."
gunzip -fr solvers

echo "Adding No_dtoa to CFLAGS..."
cd solvers
mv makefile.u makefile.u.orig
sed -e 's/CFLAGS = /CFLAGS = -DNo_dtoa /g' makefile.u.orig > makefile.u 
cd ..

echo "Deleting the tar file..."
rm solvers.tar

echo " "
echo "Done downloading the source code for ASL."
echo " "

