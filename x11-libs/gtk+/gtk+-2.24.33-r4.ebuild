# Copyright 1999-2023 Gentoo Authors and Martin V\"ath
# Distributed under the terms of the GNU General Public License v2

EAPI=8
GNOME2_EAUTORECONF="yes"

inherit git-r3 flag-o-matic gnome2 multilib multilib-minimal readme.gentoo-r1 virtualx

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"
#SRC_URI=${SRC_URI}
EGIT_REPO_URI="https://github.com/stefan11111/gtk2.git"
#EGIT_BRANCH="devel"

LICENSE="LGPL-2+"
SLOT="2"

IUSE="adwaita-icon-theme X directfb print cups +introspection vim-syntax xinerama"

# Disable deprecation warnings
#CFLAGS="-Wno-deprecated-declarations ${CFLAGS}"

KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

# Upstream wants us to do their job:
# https://bugzilla.gnome.org/show_bug.cgi?id=768663#c1
# Also no longer in the codebase
RESTRICT="test"

REQUIRED_USE="cups? ( print ) at-most-one-of ( X directfb )"

COMMON_DEPEND="
	>=dev-libs/glib-2.34.3:2[${MULTILIB_USEDEP}]
	>=media-libs/fontconfig-2.10.92[${MULTILIB_USEDEP}]
	>=x11-libs/cairo-1.12.14-r4:=[svg(+),${MULTILIB_USEDEP}]
	>=x11-libs/gdk-pixbuf-2.30.7:2[introspection?,${MULTILIB_USEDEP}]
	>=x11-libs/pango-1.36.3[introspection?,${MULTILIB_USEDEP}]
	x11-misc/shared-mime-info

	cups? ( >=net-print/cups-1.7.1-r2:=[${MULTILIB_USEDEP}] )

	introspection? ( >=dev-libs/gobject-introspection-0.9.3:=
			 dev-libs/gobject-introspection-common )

	X? (
		>=x11-libs/cairo-1.12.14-r4:=[svg(+),X,${MULTILIB_USEDEP}]
		>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXcomposite-0.4.4-r1[${MULTILIB_USEDEP}]
		>=x11-libs/libXcursor-1.1.14[${MULTILIB_USEDEP}]
		>=x11-libs/libXdamage-1.1.4-r1[${MULTILIB_USEDEP}]
		>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXfixes-5.0.1[${MULTILIB_USEDEP}]
		>=x11-libs/libXi-1.7.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXrandr-1.5[${MULTILIB_USEDEP}]
		>=x11-libs/libXrender-0.9.8[${MULTILIB_USEDEP}]
	)

	xinerama? ( >=x11-libs/libXinerama-1.1.3[${MULTILIB_USEDEP}] )

        directfb? ( >=x11-libs/cairo-1.12.14-r4:=[svg(+),directfb(-),${MULTILIB_USEDEP}] )
"
DEPEND="${COMMON_DEPEND}
	x11-base/xorg-proto
"

# gtk+-2.24.8 breaks Alt key handling in <=x11-libs/vte-0.28.2:0
# Add blocker against old gtk-builder-convert to be sure we maintain both
# in sync.
RDEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-update-icon-cache-2
	adwaita-icon-theme? (
		>=x11-themes/adwaita-icon-theme-3.14
		x11-themes/gnome-themes-standard
	)
	!<dev-util/gtk-builder-convert-${PV}
"
# librsvg for svg icons (PDEPEND to avoid circular dep), bug #547710
PDEPEND="
	adwaita-icon-theme? (
		gnome-base/librsvg[${MULTILIB_USEDEP}]
		x11-themes/gtk-engines-adwaita
	)
	vim-syntax? ( app-vim/gtk-syntax )
"
BDEPEND="
	dev-util/glib-utils
	>=dev-build/gtk-doc-am-1.20
	virtual/pkgconfig
"

DISABLE_AUTOFORMATTING="yes"
DOC_CONTENTS="To make the gtk2 file chooser use 'current directory' mode by default,
edit ~/.config/gtk-2.0/gtkfilechooser.ini to contain the following:
[Filechooser Settings]
StartupMode=cwd"

set_gtk2_confdir() {
	# An arch specific config directory is used on multilib systems
	GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
}

src_prepare() {
	gnome2_src_prepare
}

multilib_src_configure() {
	[[ ${ABI} == ppc64 ]] && append-flags -mminimal-toc

    local myeconfargs=(
    )

	use X && myeconfargs+=(--with-gdktarget=x11)
	use directfb && myeconfargs+=(--with-gdktarget=directfb)

	use xinerama && myeconfargs+=(--enable-xinerama)

	use introspection && myeconfargs+=(--enable-introspection)

	use print && myeconfargs+=(--enable-print)

	use cups && myeconfargs+=(--enable-cups)

	use cups && myeconfargs+=(CUPS_CONFIG="${EPREFIX}/usr/bin/${CHOST}-cups-config")

	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_test() {
	virtx emake check
}

multilib_src_install() {
	gnome2_src_install
}

multilib_src_install_all() {
	# see bug #133241
	# Also set more default variables in sync with gtk3 and other distributions
	insinto /usr/share/gtk-2.0
	newins - gtkrc <<- 'EOF'
	gtk-fallback-icon-theme = "gnome"
	gtk-theme-name = "Adwaita"
	gtk-icon-theme-name = "$(usex Adwaita gnome)"
	gtk-cursor-theme-name = "Adwaita"
	EOF

	readme.gentoo_create_doc
}

pkg_postinst() {
	gnome2_pkg_postinst

	set_gtk2_confdir

	if [ -e "${EROOT}/etc/gtk-2.0/gtk.immodules" ]; then
		elog "File /etc/gtk-2.0/gtk.immodules has been moved to \$CHOST"
		elog "aware location. Removing deprecated file."
		rm -f "${EROOT}/etc/gtk-2.0/gtk.immodules"
	fi

	if [ -e "${EROOT}${GTK2_CONFDIR}/gtk.immodules" ]; then
		elog "File /etc/gtk-2.0/gtk.immodules has been moved to"
		elog "${EROOT}/usr/$(get_libdir)/gtk-2.0/2.10.0/immodules.cache"
		elog "Removing deprecated file."
		rm -f "${EROOT}${GTK2_CONFDIR}/gtk.immodules"
	fi

	# pixbufs are now handled by x11-libs/gdk-pixbuf
	if [ -e "${EROOT}${GTK2_CONFDIR}/gdk-pixbuf.loaders" ]; then
		elog "File ${EROOT}${GTK2_CONFDIR}/gdk-pixbuf.loaders is now handled by x11-libs/gdk-pixbuf"
		elog "Removing deprecated file."
		rm -f "${EROOT}${GTK2_CONFDIR}/gdk-pixbuf.loaders"
	fi

	# two checks needed since we dropped multilib conditional
	if [ -e "${EROOT}/etc/gtk-2.0/gdk-pixbuf.loaders" ]; then
		elog "File ${EROOT}/etc/gtk-2.0/gdk-pixbuf.loaders is now handled by x11-libs/gdk-pixbuf"
		elog "Removing deprecated file."
		rm -f "${EROOT}/etc/gtk-2.0/gdk-pixbuf.loaders"
	fi

	if [ -e "${EROOT}"/usr/lib/gtk-2.0/2.[^1]* ]; then
		elog "You need to rebuild ebuilds that installed into" "${EROOT}"/usr/lib/gtk-2.0/2.[^1]*
		elog "to do that you can use qfile from portage-utils:"
		elog "emerge -va1 \$(qfile -qC ${EPREFIX}/usr/lib/gtk-2.0/2.[^1]*)"
	fi

	if ! has_version "app-text/evince"; then
		elog "Please install app-text/evince for print preview functionality."
		elog "Alternatively, check \"gtk-print-preview-command\" documentation and"
		elog "add it to your gtkrc."
	fi

	if use cups; then
		elog "Might want to add x11-misc/xdg-utils and net-print/cups-filters to"
		elog "/etc/portage/profile/package.provided to not install bloated dependencies"
	fi

	readme.gentoo_print_elog
}

pkg_postrm() {
	gnome2_pkg_postrm

	if [[ -z ${REPLACED_BY_VERSION} ]]; then
		multilib_pkg_postrm() {
			rm -f "${EROOT}/usr/$(get_libdir)/gtk-2.0/2.10.0/immodules.cache"
		}
		multilib_foreach_abi multilib_pkg_postrm
	fi
}
