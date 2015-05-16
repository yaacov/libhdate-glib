NULL = 

AM_CPPFLAGS = \
	$(HDATE_GLIB_CFLAGS) \
	-include $(CONFIG_HEADER) \
	$(NULL)

lib_LTLIBRARIES = libhdate_glib.la

include_HEADERS = hdate-glib.h

libhdate_glib_la_VALAFLAGS = \
	 --pkg libhdate --vapidir=../vapi \	
	--library hdate-glib -H hdate-glib.h --vapi=../vapi/libhdate-glib.vapi

libhdate_glib_la_SOURCES = \
	hdate-glib.vala \
	$(NULL)

libhdate_glib_la_LIBADD = \
	$(HDATE_GLIB_LIBS) \
	$(NULL)

EXTRA_DIST = \
	$(NULL)

DISTCLEANFILES = \
	$(NULL)

CLEANFILES = \
	$(NULL)

-include $(INTROSPECTION_MAKEFILE)
INTROSPECTION_GIRS =
INTROSPECTION_SCANNER_ARGS = --add-include-path=$(srcdir)
INTROSPECTION_COMPILER_ARGS = --includedir=$(srcdir)

if HAVE_INTROSPECTION
introspection_sources = $(libhdate_glib_la_SOURCES) hdate-glib.h hdate-glib.c

LibHdateGlib-1.0.gir: libhdate_glib.la
LibHdateGlib_1_0_gir_INCLUDES = GObject-2.0
LibHdateGlib_1_0_gir_CFLAGS = $(INCLUDES)
LibHdateGlib_1_0_gir_LIBS = libhdate_glib.la
LibHdateGlib_1_0_gir_FILES = $(introspection_sources)
LibHdateGlib_1_0_gir_PACKAGES = libhdate
LibHdateGlib_1_0_gir_NAMESPACE = LibHdateGlib
INTROSPECTION_GIRS += LibHdateGlib-1.0.gir

girdir = $(datadir)/gir-1.0
gir_DATA = $(INTROSPECTION_GIRS)

typelibdir = $(libdir)/girepository-1.0
typelib_DATA = $(INTROSPECTION_GIRS:.gir=.typelib)

CLEANFILES += $(gir_DATA) $(typelib_DATA)
endif


