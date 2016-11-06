#!/bin/sh
# Run this to generate all the initial makefiles, etc.

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

PKG_NAME="udisks"

(test -f $srcdir/src/Makefile.am) || {
    echo -n "**Error**: Directory "\`$srcdir\'" does not look like the"
    echo " top-level $PKG_NAME directory"
    exit 1
}

mkdir -p m4
autoreconf -fi

./configure "$@"
