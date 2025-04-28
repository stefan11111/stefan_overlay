# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Small implementation of GLUT (OpenGL Utility Toolkit)"
HOMEPAGE="https://github.com/caramelli/TinyGLUT"
EGIT_REPO_URI="https://github.com/caramelli/TinyGLUT.git"

inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dummy x11 xcb directfb fbdev wayland egl glx dfbgl glfbdev tests"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        dev-build/autoconf
        dev-build/automake
        tests? ( dev-libs/libfiu )
        x11? ( x11-libs/libX11 )
        xcb? ( x11-libs/libxcb )
        directfb? ( virtual/directfb )
        wayland? ( dev-libs/wayland
                   dev-libs/wayland-protocols )
"

RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    local emesonargs=(
        $(meson_use dummy)
        $(meson_use x11)
        $(meson_use xcb)
        $(meson_use directfb)
        $(meson_use fbdev)
        $(meson_use wayland)
        $(meson_use egl)
        $(meson_use glx)
        $(meson_use dfbgl)
        $(meson_use glfbdev)
        $(meson_use tests)
    )

    meson_src_configure
}

src_compile() {
    meson_src_compile
}

src_install() {
    meson_src_install
}
