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

## Jacobians with for more than 2^31 nonzeros

If selecting configure option `--with-intsize=64`, a define for `ASL_big_goff`
will be enabled. This allows ASL to compute Jacobians with more than 2^31
entries. Some solvers may be able to make use of this.

The name of the configure option is chosen to be compatible with some other
projects, in particular, ThirdParty-Mumps and Ipopt. However, in the context
of ASL it actually changes the type of some index variables from int to ssize_t.
On many common 64-bit systems, int has a size of 32 bit and ssize_t has a size of 64 bit.
