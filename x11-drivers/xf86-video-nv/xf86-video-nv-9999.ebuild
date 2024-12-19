# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Minimal NVIDIA video driver for the Xorg X server"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/driver/xf86-video-nv"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-video-nv.git"
inherit git-r3 autotools

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xaa"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        x11-libs/xorg-macros"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
    default
    eautoreconf
}

src_configure() {
    use xaa && econf --enable-xaa
    use !xaa && econf
}

src_compile() {
    emake
}

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
}
