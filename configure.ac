AC_INIT([libhdate-glib], [0.5.0], [kobi.zamir@gmail.com], [libhdate-glib])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_HEADERS(config.h)
AM_INIT_AUTOMAKE([dist-bzip2])
AM_MAINTAINER_MODE
 
AC_PROG_CC
AM_PROG_CC_C_O
AC_DISABLE_STATIC
AC_PROG_LIBTOOL

AC_PATH_PROG(VALAC, valac, valac)
AC_SUBST(VALAC)

AC_SUBST(CFLAGS)
AC_SUBST(CPPFLAGS)
AC_SUBST(LDFLAGS)

GLIB_REQUIRED=2.12.0
HDATE_REQUIRED=1.6.0

AC_ARG_WITH(vala-pkg,
	[AS_HELP_STRING([--with-vala-pkg=PKG],
	[vala pkg-config package])])

if test "$with_vala_pkg" = "" ; then
	valac_version_cur=`$VALAC --version | cut -d" " -f2 | cut -d. -f1`
	valac_version_rev=`$VALAC --version | cut -d" " -f2 | cut -d. -f2`
	VALA_PKG="libvala-"$valac_version_cur.$valac_version_rev
else
	VALA_PKG=$with_vala_pkg
fi

libhdate_version=`pkg-config --modversion libhdate`

PKG_CHECK_MODULES(HDATE_GLIB, libhdate >= $HDATE_REQUIRED $VALA_PKG glib-2.0 >= $GLIB_REQUIRED gobject-2.0 >= $GLIB_REQUIRED)
AC_SUBST(HDATE_GLIB_CFLAGS)
AC_SUBST(HDATE_GLIB_LIBS)

GOBJECT_INTROSPECTION_CHECK([0.6.7])

VAPIDIR=`pkg-config --variable=vapidir $VALA_PKG`
AC_SUBST(VAPIDIR)

AC_CONFIG_FILES([Makefile
	libhdate-glib.pc
	vapi/Makefile
	examples/Makefile
	src/Makefile])

AC_OUTPUT

echo
echo "libvala-glib:   $VERSION"
echo "------------------------"
echo "using libhdate: $libhdate_version"
echo "using vala-pkg: $VALA_PKG"
echo "using valac:    $VALAC"

