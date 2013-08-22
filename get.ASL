#!/bin/sh

set -e

wgetcmd="wget --no-check-certificate"
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

echo " "
echo "Running script for downloading the source code for the ASL"
echo " "

rm -f solvers.tar

echo "Downloading the source code from projects.coin-or.org..."
if $wgetcmd https://projects.coin-or.org/svn/BuildTools/ThirdParty/ASL/src/solvers-20130815.tar ;
then
  mv solvers-20130815.tar solvers.tar
else
  echo
  echo "Failed, try downloading the source code from www.netlib.org..."
  if ! $wgetcmd ftp://www.netlib.org/ampl/solvers.tar ;
  then
    echo
    echo "Failed, try downloading the source code from netlib.sandia.gov..."
    rm -f netlibfiles.tar*
    $wgetcmd http://netlib.sandia.gov/cgi-bin/netlib/netlibfiles.tar?filename=netlib/ampl/solvers
    mv netlibfiles.tar* solvers.tar
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

