## Process this file with automake to produce Makefile.in

SUBDIRS =

NULL =

INCLUDES = \
	-I$(top_builddir) -I$(top_srcdir)	 		\
	-DPACKAGE_LIBEXEC_DIR=\""$(libexecdir)"\" 		\
	-DPACKAGE_SYSCONF_DIR=\""$(sysconfdir)"\" 		\
	-DPACKAGE_DATA_DIR=\""$(datadir)"\" 			\
	-DPACKAGE_BIN_DIR=\""$(bindir)"\" 			\
	-DPACKAGE_LOCALSTATE_DIR=\""$(localstatedir)"\" 	\
	-DPACKAGE_LOCALE_DIR=\""$(localedir)"\" 		\
	-DPACKAGE_LIB_DIR=\""$(libdir)"\" 			\
	-D_POSIX_PTHREAD_SEMANTICS -D_REENTRANT			\
	-DUDISKS_COMPILATION					\
	$(GLIB_CFLAGS) 						\
	$(GIO_CFLAGS)						\
	$(WARN_CFLAGS)						\
	$(NULL)

$(dbus_built_sources) : Makefile.am $(top_srcdir)/data/org.freedesktop.UDisks2.xml
	gdbus-codegen							                \
		--interface-prefix org.freedesktop.UDisks2.                          	\
		--c-namespace UDisks							\
		--c-generate-object-manager						\
		--generate-c-code udisks-generated                             		\
		--generate-docbook udisks-generated-doc					\
		$(top_srcdir)/data/org.freedesktop.UDisks2.xml         			\
		$(NULL)

udisksenumtypes.h: udisksenums.h udisksenumtypes.h.template
	( top_builddir=`cd $(top_builddir) && pwd`; 						\
	 cd $(srcdir) && glib-mkenums --template udisksenumtypes.h.template udisksenums.h ) | 	\
	   sed 's,U_TYPE_DISKS,UDISKS_TYPE,' | sed 's,u_disks,udisks,' > 			\
	   udisksenumtypes.h.tmp && mv udisksenumtypes.h.tmp udisksenumtypes.h

udisksenumtypes.c: udisksenums.h udisksenumtypes.c.template
	( top_builddir=`cd $(top_builddir) && pwd`; 						\
	 cd $(srcdir) && glib-mkenums --template udisksenumtypes.c.template udisksenums.h ) | 	\
	   sed 's,U_TYPE_DISKS,UDISKS_TYPE,' | sed 's,u_disks,udisks,' > 			\
	   udisksenumtypes.c.tmp && mv udisksenumtypes.c.tmp udisksenumtypes.c

enum_built_sources =									\
	udisksenumtypes.h			udisksenumtypes.c			\
	$(NULL)

dbus_built_sources =									\
	udisks-generated.h			udisks-generated.c			\
	$(NULL)

BUILT_SOURCES =										\
	$(enum_built_sources)								\
	$(dbus_built_sources)								\
	$(NULL)

lib_LTLIBRARIES=libudisks2.la

libudisks2includedir=$(includedir)/udisks2/udisks

libudisks2include_HEADERS=								\
	udisks.h									\
	udisksclient.h									\
	udisksenums.h									\
	udisksenumtypes.h								\
	udiskserror.h									\
	udiskstypes.h									\
	udisksutil.h									\
	udisks-generated.h								\
	$(NULL)

libudisks2_la_SOURCES =									\
	$(BUILT_SOURCES)								\
	udisksclient.h				udisksclient.c				\
	udisksenums.h									\
	udiskserror.h				udiskserror.c				\
	udiskstypes.h									\
	udisksutil.h				udisksutil.c				\
	$(NULL)

libudisks2_la_CPPFLAGS = 				\
	-DG_LOG_DOMAIN=\"libudisks2\"			\
	$(NULL)

libudisks2_la_CFLAGS = 					\
	$(GLIB_CFLAGS)					\
	$(GIO_CFLAGS)					\
	$(NULL)

libudisks2_la_LIBADD = 					\
	$(GLIB_LIBS)					\
	$(GIO_LIBS)					\
	$(NULL)

# ----------------------------------------------------------------------------------------------------

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = udisks2.pc

# ----------------------------------------------------------------------------------------------------

if HAVE_INTROSPECTION
girdir = $(INTROSPECTION_GIRDIR)
gir_DATA = UDisks-2.0.gir

typelibsdir = $(INTROSPECTION_TYPELIBDIR)
typelibs_DATA = UDisks-2.0.typelib

UDisks-2.0.gir: libudisks2.la $(INTROSPECTION_SCANNER) Makefile.am
	$(INTROSPECTION_SCANNER) -v 				\
		--warn-all					\
		--namespace UDisks 				\
		--identifier-prefix UDisks			\
		--symbol-prefix	udisks				\
		--nsversion=2.0 				\
		--include=Gio-2.0 				\
		--library=udisks2	 			\
		--output $@ 					\
		--pkg=glib-2.0 					\
		--pkg=gobject-2.0 				\
		--pkg=gio-2.0 					\
		--libtool=$(top_builddir)/libtool		\
		--c-include='udisks/udisks.h'			\
                -I$(top_srcdir)		 			\
	        -DUDISKS_COMPILATION                   		\
		$(libudisks2_la_SOURCES)			\
		$(NULL)

UDisks-2.0.typelib: UDisks-2.0.gir $(INTROSPECTION_COMPILER)
	$(INTROSPECTION_COMPILER) $< -o $@

endif # HAVE_INTROSPECTION

# ----------------------------------------------------------------------------------------------------

CLEANFILES = udisks-generated-doc-*.xml $(gir_DATA) $(typelibs_DATA)

EXTRA_DIST = 						\
	udisks2.pc.in					\
	udisksenumtypes.h.template			\
	udisksenumtypes.c.template			\
	$(NULL)

clean-local :
	rm -f *~ $(BUILT_SOURCES)