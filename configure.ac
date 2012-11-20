C_INIT([enigma2-plugins],[3.0.0])
AM_INIT_AUTOMAKE([dist-bzip2 foreign no-define tar-pax])

# Silent rules are available since 1.11, but older versions
# are still in use. So don't use them unconditionally.
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_USE_SYSTEM_EXTENSIONS
AC_SYS_LARGEFILE

AC_PROG_CC
AC_PROG_CXX
m4_ifdef([LT_INIT], [LT_INIT], [AC_PROG_LIBTOOL])
AC_CONFIG_MACRO_DIR([m4])

AC_PATH_PROG(MSGFMT, msgfmt, AC_MSG_ERROR(Could not find msgfmt))

AM_PATH_PYTHON
AX_PYTHON_DEVEL
AX_PTHREAD

PKG_CHECK_MODULES(LIBCRYPTO, libcrypto)

AC_ARG_WITH(debug,
	AS_HELP_STRING([--without-debug],[disable debugging code]),
	[with_debug="$withval"],[with_debug="no"])
if test "$with_debug" = "yes"; then
	DEBUG_CFLAGS="-ggdb3"
	AC_DEFINE([DEBUG],[1],[Define to 1 to enable debugging code])
fi

AC_ARG_WITH(po,
	AS_HELP_STRING([--with-po],[enable updating of po files]),
	[with_po="$withval"],[with_po="no"])
if test "$with_po" = "yes"; then
	AC_PATH_PROG(MSGINIT, msginit)
	AC_PATH_PROG(MSGMERGE, msgmerge)
	AC_PATH_PROG(MSGUNIQ, msguniq)
	AC_PATH_PROG(XGETTEXT, xgettext)
	if test -z "$MSGINIT" -o -z "$MSGMERGE" -o -z "$MSGUNIQ" -o -z "$XGETTEXT"; then
		AC_MSG_ERROR([Could not find required gettext tools])
	fi
fi
AM_CONDITIONAL(UPDATE_PO, test "$with_po" = "yes")

CPPFLAGS="$CPPFLAGS $PYTHON_CPPFLAGS -include Python.h"
CFLAGS="$CFLAGS $DEBUG_CFLAGS -Wall"
CXXFLAGS="$CXXFLAGS $DEBUG_CFLAGS -Wall $ENIGMA2_CFLAGS $PTHREAD_CFLAGS"

AC_CONFIG_FILES([
/boxtypes/ET9x00/menu/Makefile
/boxtypes/ET9x00/scripts/Makefile
/boxtypes/ET9x00/Makefile
/boxtypes/TM-Twin/menu/Makefile
/boxtypes/TM-Twin/scripts/Makefile
/boxtypes/TM-Twin/Makefile
/boxtypes/GigaBlue/menu/Makefile
/boxtypes/GigaBlue/scripts/Makefile
/boxtypes/GigaBlue/Makefile
/boxtypes/Makefile
/boxtypes/Vu+Solo/menu/Makefile
/boxtypes/Vu+Solo/scripts/Makefile
/boxtypes/Vu+Solo/Makefile
/boxtypes/Ixuss/menu/Makefile
/boxtypes/Ixuss/scripts/Makefile
/boxtypes/Ixuss/Makefile
/boxtypes/TM800/menu/Makefile
/boxtypes/TM800/scripts/Makefile
/boxtypes/TM800/Makefile
/boxtypes/Vu+Duo/menu/Makefile
/boxtypes/Vu+Duo/scripts/Makefile
/boxtypes/Vu+Duo/Makefile
/meta/Makefile
/Makefile
])
AC_OUTPUT

