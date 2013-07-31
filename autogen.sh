#!/bin/bash
# Run this to generate all the initial makefiles, etc.

usage() {
  echo >&2 "\
Usage: $0 [OPTION]...
Generate makefiles and other infrastructure needed for building
"
}

BUILD_AUX=build/aux
GNULIB_DIR=gnulib

set -e
srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

THEDIR=`pwd`
cd $srcdir

# Split out options for bootstrap and for configure
declare -a CF_ARGS
for option
do
  case $option in
  --help)
    usage
    exit;;
  --gnulib-srcdir=*)
    GNULIB_SRCDIR=$option;;
  *)
    CF_ARGS[${#CF_ARGS[@]}]=$option;;
  esac
done

#Check for OSX
case `uname -s` in
Darwin) LIBTOOLIZE=glibtoolize;;
*) LIBTOOLIZE=libtoolize;;
esac


DIE=0

(autoconf --version) < /dev/null > /dev/null 2>&1 || {
	echo
	echo "You must have autoconf installed to compile."
	echo "Download the appropriate package for your distribution,"
	echo "or see http://www.gnu.org/software/autoconf"
	DIE=1
}

(automake --version) < /dev/null > /dev/null 2>&1 || {
	echo
	DIE=1
	echo "You must have automake installed to compile."
	echo "Download the appropriate package for your distribution,"
	echo "or see http://www.gnu.org/software/automake"
}

if test "$DIE" -eq 1; then
	exit 1
fi

if test -z "${CF_ARGS[*]}"; then
	echo "I am going to run ./configure with --enable-warnings - if you "
        echo "wish to pass any extra arguments to it, please specify them on "
        echo "the $0 command line."
fi

mkdir -p $BUILD_AUX

$LIBTOOLIZE --copy --force
#aclocal -I gnulib/m4
aclocal
autoheader
automake --add-missing --foreign
autoconf

cd $THEDIR

if test x$OBJ_DIR != x; then
    mkdir -p "$OBJ_DIR"
    cd "$OBJ_DIR"
fi

$srcdir/configure "${CF_ARGS[@]}" && {
    echo
    echo "Now type 'make' to compile."
}
