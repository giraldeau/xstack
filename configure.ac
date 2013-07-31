AC_INIT([xstack], 0.0.1)
AC_CONFIG_SRCDIR([src/main.c])
AM_CONFIG_HEADER([config.h])
AM_INIT_AUTOMAKE([-Wall])
AM_INIT_AUTOMAKE([color-tests])

LT_INIT

AC_CHECK_HEADERS(sys/types.h unistd.h fcntl.h strings.h pthread.h time.h errno.h stdarg.h limits.h signal.h stdlib.h time.h)
AC_CHECK_HEADERS(inttypes.h math.h)
AC_CHECK_LIB(pthread, pthread_create)

AC_MSG_CHECKING(whether to enable debug mode)
debug_default="no"
AC_ARG_ENABLE(debug,
        AS_HELP_STRING([--enable-debug],[turn on debug mode [[default=no]]])
        , , enable_debug=$debug_default)
if test "$enable_debug" = "yes"; then
    AC_MSG_RESULT(yes)
    CFLAGS="-Wall -g -O0 -fno-inline -fno-omit-frame-pointer"
    AC_DEFINE([DEBUG],[],[Debug])
else
    AC_MSG_RESULT(no)
    CFLAGS="-Wall -O3 -fomit-frame-pointer"
fi

pkg_glib="glib-2.0 >= 2.0.0"
PKG_CHECK_MODULES(GLIB, [$pkg_glib])

# be silent by default
AM_SILENT_RULES([yes])

AC_PROG_LIBTOOL
AC_PROG_CC
AC_PROG_CXX
AM_PROG_CC_C_O
AC_PROG_RANLIB
AC_CONFIG_FILES([Makefile
    src/Makefile])
AC_OUTPUT
