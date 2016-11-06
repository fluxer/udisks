## Process this file with automake to produce Makefile.in

NULL =

SUBDIRS = data udisks src tools doc

ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}

GCC_COLORS ?= 'auto'
export GCC_COLORS

EXTRA_DIST = 			\
	HACKING 		\
	$(NULL)

DISTCHECK_CONFIGURE_FLAGS=							\
	--disable-introspection							\
	--with-udevdir=$$dc_install_base/$(udevdir)				\
	--with-systemdsystemunitdir=$$dc_install_base/$(systemdsystemunitdir)	\
	$(NULL)

sign : dist
	gpg --armor --detach-sign --output udisks-$(VERSION).tar.bz2.sign udisks-$(VERSION).tar.bz2

clean-local :
	rm -f *~
