
NULL =

dbusservicedir       = $(datadir)/dbus-1/system-services
dbusservice_in_files = org.freedesktop.UDisks2.service.in
dbusservice_DATA     = $(dbusservice_in_files:.service.in=.service)

$(dbusservice_DATA): $(dbusservice_in_files) Makefile
	@sed -e "s|\@udisksdprivdir\@|$(libexecdir)/udisks2|" $< > $@

dbusconfdir = $(sysconfdir)/dbus-1/system.d
dbusconf_in_files = org.freedesktop.UDisks2.conf.in
dbusconf_DATA = $(dbusconf_in_files:.conf.in=.conf)

$(dbusconf_DATA): $(dbusconf_in_files) Makefile
	cp $< $@

systemdservice_in_files = udisks2.service.in

if HAVE_SYSTEMD
systemdservicedir       = $(systemdsystemunitdir)
systemdservice_DATA     = $(systemdservice_in_files:.service.in=.service)

$(systemdservice_DATA): $(systemdservice_in_files) Makefile
	@sed -e "s|\@udisksdprivdir\@|$(libexecdir)/udisks2|" $< > $@
endif

udevrulesdir = $(udevdir)/rules.d
udevrules_DATA = 80-udisks2.rules

completionsdir = $(datadir)/bash-completion/completions
completions_DATA = 					\
	completions/udisksctl				\
	$(NULL)

EXTRA_DIST = 						\
	80-udisks2.rules				\
	org.freedesktop.UDisks2.xml			\
	$(systemdservice_in_files)			\
	$(dbusservice_in_files)				\
	$(dbusconf_in_files)				\
	$(completions_DATA)				\
	$(NULL)

clean-local :
	rm -f *~ $(dbusservice_DATA) $(dbusconf_DATA) $(systemdservice_DATA)
