# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-minimal

WXSUBVERSION=${PV}-gtk3				# 3.0.5.1-gtk3
WXVERSION=${WXSUBVERSION%.*}			# 3.0.5
WXRELEASE=${WXVERSION%.*}-gtk3			# 3.0-gtk3
WXRELEASE_NODOT=${WXRELEASE//./}		# 30-gtk3

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit"
HOMEPAGE="https://wxwidgets.org/"
SRC_URI="
	https://github.com/wxWidgets/wxWidgets/releases/download/v${PV}/wxWidgets-${PV}.tar.bz2
	https://dev.gentoo.org/~leio/distfiles/wxGTK-3.0.5_p20210214.tar.xz
	doc? ( https://github.com/wxWidgets/wxWidgets/releases/download/v${WXVERSION}/wxWidgets-${WXVERSION}-docs-html.tar.bz2 )"
S="${WORKDIR}/wxWidgets-${PV}"

LICENSE="wxWinLL-3 GPL-2 doc? ( wxWinFDL-3 )"
SLOT="${WXRELEASE}"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ~mips ppc ppc64 ~riscv sparc x86 ~amd64-linux ~x86-linux"
IUSE="+X directfb X11 doc debug gstreamer libnotify opengl pch sdl test tiff webkit compat26 compat28 nodebug zlib expat graphics_ctx gtkprint gui gtk2 gtk3 pcre png jpeg xrc unicode"
REQUIRED_USE="test? ( tiff ) tiff? ( X )"
RESTRICT="!test? ( test ) ^^ ( X11 directfb gtk2 gtk3 )"

RDEPEND="
	>=app-eselect/eselect-wxwidgets-20131230
	expat? (
		dev-libs/expat[${MULTILIB_USEDEP}]
	)
	sdl? ( media-libs/libsdl2[${MULTILIB_USEDEP}] )
	X? (
		>=dev-libs/glib-2.22:2[${MULTILIB_USEDEP}]
		jpeg? (
			media-libs/libjpeg-turbo:=[${MULTILIB_USEDEP}]
		)
		png? (
			media-libs/libpng:0=[${MULTILIB_USEDEP}]
		)
		zlib? (
			sys-libs/zlib[${MULTILIB_USEDEP}]
		)
		x11-libs/cairo[${MULTILIB_USEDEP}]
		gtk2? (
			x11-libs/gtk+:2[X(+),${MULTILIB_USEDEP}]
		)
		gtk3? (
			x11-libs/gtk+:3[${MULTILIB_USEDEP}]
		)
		x11-libs/gdk-pixbuf[${MULTILIB_USEDEP}]
		x11-libs/libSM[${MULTILIB_USEDEP}]
		x11-libs/libX11[${MULTILIB_USEDEP}]
		x11-libs/libXxf86vm[${MULTILIB_USEDEP}]
		x11-libs/pango[${MULTILIB_USEDEP}]
		gstreamer? (
			media-libs/gstreamer:1.0[${MULTILIB_USEDEP}]
			media-libs/gst-plugins-base:1.0[${MULTILIB_USEDEP}]
		)
		libnotify? ( x11-libs/libnotify[${MULTILIB_USEDEP}] )
		opengl? ( virtual/opengl[${MULTILIB_USEDEP}] )
		tiff? ( media-libs/tiff:=[${MULTILIB_USEDEP}] )
		webkit? ( net-libs/webkit-gtk:4 )
	)
	directfb? ( virtual/directfb )
	"
DEPEND="${RDEPEND}
	opengl? ( virtual/glu[${MULTILIB_USEDEP}] )
	X? ( x11-base/xorg-proto )"
BDEPEND="
	test? ( >=dev-util/cppunit-1.8.0 )
	>=app-eselect/eselect-wxwidgets-20131230
	virtual/pkgconfig"

PATCHES=(
	"${WORKDIR}"/wxGTK-3.0.5_p20210214/
	"${FILESDIR}"/wxGTK-${SLOT}-translation-domain.patch
	"${FILESDIR}"/wxGTK-ignore-c++-abi.patch #676878
	"${FILESDIR}"/${PN}-configure-tests.patch
	"${FILESDIR}"/${PN}-3.0.5.1-configure-modern-c.patch
	"${FILESDIR}"/wxGTK-directfb.patch
)

src_prepare() {
	default

	# Versionating
	sed -i \
		-e "s:\(WX_RELEASE = \).*:\1${WXRELEASE}:"\
		-e "s:\(WX_RELEASE_NODOT = \).*:\1${WXRELEASE_NODOT}:"\
		-e "s:\(WX_VERSION = \).*:\1${WXVERSION}:"\
		-e "s:aclocal):aclocal/wxwin${WXRELEASE_NODOT}.m4):" \
		-e "s:wxstd.mo:wxstd${WXRELEASE_NODOT}.mo:" \
		-e "s:wxmsw.mo:wxmsw${WXRELEASE_NODOT}.mo:" \
		Makefile.in tests/Makefile.in || die

	sed -i \
		-e "s:\(WX_RELEASE = \).*:\1${WXRELEASE}:"\
		utils/wxrc/Makefile.in || die

	sed -i \
		-e "s:\(WX_VERSION=\).*:\1${WXVERSION}:" \
		-e "s:\(WX_RELEASE=\).*:\1${WXRELEASE}:" \
		-e "s:\(WX_SUBVERSION=\).*:\1${WXSUBVERSION}:" \
		-e '/WX_VERSION_TAG=/ s:${WX_RELEASE}:3.0:' \
		configure || die
}

multilib_src_configure() {
	# X independent options
	local myeconfargs=(
		--disable-compat26
		--disable-compat28
		$(use_with sdl)

		# PCHes are unstable and are disabled in-tree where possible
		# See bug #504204
		# Commits 8c4774042b7fdfb08e525d8af4b7912f26a2fdce, fb809aeadee57ffa24591e60cfb41aecd4823090
		$(use_enable pch precomp-headers)

		# Don't hard-code libdir's prefix for wx-config
		--libdir='${prefix}'/$(get_libdir)
	)

	use compat26 && myeconfargs+=( --enable-compat26 )
	use compat28 && myeconfargs+=( --enable-compat28 )

	use zlib && myeconfargs+=( --with-zlib=sys )
	use !zlib && myeconfargs+=( --without-zlib )

	use expat && myeconfargs+=( --with-expat=sys )
	use !expat && myeconfargs+=( --without-expat )

	use xrc && myeconfargs+=( --enable-xrc )
	use !xrc && myeconfargs+=( --disable-xrc )

	use unicode && myeconfargs+=( --enable-unicode )
	use !unicode && myeconfargs+=( --disable-unicode )

	# debug in >=2.9
	# there is no longer separate debug libraries (gtk2ud)
	# wxDEBUG_LEVEL=1 is the default and we will leave it enabled
	# wxDEBUG_LEVEL=2 enables assertions that have expensive runtime costs.
	# apps can disable these features by building w/ -NDEBUG or wxDEBUG_LEVEL_0.
	# http://docs.wxwidgets.org/3.0/overview_debugging.html
	# https://groups.google.com/group/wx-dev/browse_thread/thread/c3c7e78d63d7777f/05dee25410052d9c
	use debug && myeconfargs+=( --enable-debug=max )
	use nodebug && myeconfargs+=( --disable-debug )

	use graphics_ctx && myeconfargs+=( --enable-graphics_ctx )
	use gtkprint && myeconfargs+=( --with-gtkprint )
	use !gtkprint && myeconfargs+=( --without-gtkprint )
	use gui  && myeconfargs+=( --enable-gui )
	use gtk2 && myeconfargs+=( --with-gtk=2 )
	use gtk3 && myeconfargs+=( --with-gtk=3 )

	#system libpcre2 doesn't work with all apps
	use pcre && myeconfargs+=( --with-regex=builtin )
	use !pcre && myeconfargs+=( --without-regex )

	use png && myeconfargs+=( --with-libpng=sys )
	use !png && myeconfargs+=( --without-libpng --disable-svg)
	use jpeg && myeconfargs+=( --with-libjpeg=sys )
	use !jpeg && myeconfargs+=( --without-libjpeg )

	# wxGTK options
	#   --enable-graphics_ctx - needed for webkit, editra
	#   --without-gnomevfs - bug #203389
	( use X || use directfb || use X11) && myeconfargs+=(
		--without-gnomevfs
		$(use_enable gstreamer mediactrl)
		$(multilib_native_use_enable webkit webview)
		$(use_with libnotify)
		$(use_with opengl)
		$(use_with tiff libtiff sys)
		$(use_enable test tests)
	)

	use X11 && myeconfargs+=( --with-x11 )
	use directfb && myeconfargs+=( --with-directfb )

	# wxBase options
	! ( use X || use directfb || use X11 ) && myeconfargs+=( --disable-gui )

	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_test() {
	emake -C tests
	(cd tests && ./test) || die
}

multilib_src_install_all() {
	cd docs || die
	dodoc changes.txt readme.txt
	newdoc base/readme.txt base_readme.txt
	newdoc gtk/readme.txt gtk_readme.txt

	use doc && HTML_DOCS=( "${WORKDIR}"/wxWidgets-${WXVERSION}-docs-html/. )
	einstalldocs

	# Stray windows locale file, bug #650118
	rm -f "${ED}"/usr/share/locale/it/LC_MESSAGES/wxmsw30-gtk3.mo || die

	# Unversioned links
	rm "${ED}"/usr/bin/wx-config || die
	use X && { rm -rf "${ED}"/usr/bin/wxrc || die; }

	# version bakefile presets
	pushd "${ED}"/usr/share/bakefile/presets >/dev/null || die
	local f
	for f in wx*; do
		mv "${f}" "${f/wx/wx30gtk3}" || die
	done
	popd >/dev/null || die
}

pkg_postinst() {
	has_version -b app-eselect/eselect-wxwidgets \
		&& eselect wxwidgets update
}

pkg_postrm() {
	has_version -b app-eselect/eselect-wxwidgets \
		&& eselect wxwidgets update
}
