#!/bin/sh

set -e

wgetcount=`which wget 2>/dev/null | wc -l`
if test ! $wgetcount = 1; then
  curlcount=`which curl 2>/dev/null | wc -l`
  if test ! $curlcount = 1; then
    fetchcount=`which fetch 2>/dev/null | wc -l`
    if test ! $fetchcount = 1; then
      echo "None of the utilities, wget, curl, or fetch found in PATH. Cannot download source."
      exit -1
    else
      wgetcmd=fetch
    fi
  else
    wgetcmd="curl -L -O"
  fi
else
wgetcmd="wget"
fi

coinasl=solvers-64919f75f

echo " "
echo "Running script for downloading the source code for the ASL"
echo " "

rm -f $coinasl

echo "Downloading the source code from www.coin-or.org..."
if $wgetcmd https://coin-or-tools.github.io/ThirdParty-ASL/${coinasl}.tgz ;
then
  echo "Download finished."
else
  echo
  echo "Downloading from COIN-OR failed, trying ampl.com..."
  if $wgetcmd https://ampl.com/netlib/ampl/solvers.tgz ;
  then
    echo "Download finished."
    mv solvers.tgz ${coinasl}.tgz
  else
    echo "Download failed...exiting"
  fi
fi

rm -rf solvers

echo "Unpacking the source code..."
gunzip -f ${coinasl}.tgz
tar xf $coinasl.tar

echo "Applying patches"
patch -p0 < mingw.patch
patch -p0 < dtoa.patch

echo "Deleting the tar file..."
rm $coinasl.tar

echo " "
echo "Done downloading the source code for ASL."
echo " "
