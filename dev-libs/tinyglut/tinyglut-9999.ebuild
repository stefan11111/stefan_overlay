# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Small implementation of GLUT (OpenGL Utility Toolkit)"
HOMEPAGE="https://github.com/caramelli/TinyGLUT"
EGIT_REPO_URI="https://github.com/caramelli/TinyGLUT.git"
inherit git-r3 autotools

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dummy x11 xcb directfb fbdev wayland egl glx dfbgl glfbdev tests"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        dev-build/autoconf
        dev-build/automake
        x11? ( x11-libs/libX11 )
        xcb? ( x11-libs/libxcb )
        directfb? ( virtual/directfb )
        wayland? ( dev-libs/wayland
                   dev-libs/wayland-protocols )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
    default
    eautoreconf
}

src_configure() {
    local myeconfargs=(
    )

        use dummy && myeconfargs+=(--enable-dummy)
        use !dummy && myeconfargs+=(--disable-dummy)

        use x11 && myeconfargs+=(--enable-x11)
        use !x11 && myeconfargs+=(--disable-x11)

        use xcb && myeconfargs+=(--enable-xcb)
        use !xcb && myeconfargs+=(--disable-xcb)

        use directfb && myeconfargs+=(--enable-directfb)
        use !directfb && myeconfargs+=(--disable-directfb)

        use fbdev && myeconfargs+=(--enable-fbdev)
        use !fbdev && myeconfargs+=(--disable-fbdev)

        use wayland && myeconfargs+=(--enable-wayland)
        use !wayland && myeconfargs+=(--disable-wayland)

        use egl && myeconfargs+=(--enable-egl)
        use !egl && myeconfargs+=(--disable-egl)

        use glx && myeconfargs+=(--enable-glx)
        use !glx && myeconfargs+=(--disable-glx)

        use dfbgl && myeconfargs+=(--enable-dfbgl)
        use !dfbgl && myeconfargs+=(--disable-dfbgl)

        use glfbdev && myeconfargs+=(--enable-glfbdev)
        use !glfbdev && myeconfargs+=(--disable-glfbdev)

        use tests && myeconfargs+=(--enable-tests)
        use !tests && myeconfargs+=(--disable-tests)

        ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_compile() {
    emake DESTDIR=${D}
}

src_install() {
    emake install DESTDIR=${D}
}
