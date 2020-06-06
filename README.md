# ThirdParty-ASL

This is an autotools-based build system to build and install the
Ampl Solver Library (ASL) as it is used by some COIN-OR projects.

## Installation steps

1. Obtain the ASL source code.

   **********************************************************************
   Note: It is YOUR RESPONSIBILITY to ensure that you are entitled to
         download and use this third party package.
   **********************************************************************

   The shell script `get.ASL` can be used to automatically download and
   extract the ASL source code. The script will first try to download a
   specific ASL version from https://coin-or-tools.github.io/ThirdParty-ASL.
   If this fails, it will attempt to download the latest version published
   by AMPL: https://ampl.com/netlib/ampl/solvers.tgz

   The script requires wget, curl, or fetch to be available on the system
   and in the shells search path (`$PATH`).

2. Run `./configure`. Use `./configure --help` to see available options.

3. Run `make` to build the ASL library.

4. Run `make install` to install the ASL library and header files.
