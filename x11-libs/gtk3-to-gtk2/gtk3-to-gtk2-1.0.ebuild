# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Compatibility library to run gtk3 apps with gtk2"
HOMEPAGE="https://github.com/stefan11111/gtk3-to-gtk2"
EGIT_REPO_URI="https://github.com/stefan11111/gtk3-to-gtk2.git"
inherit git-r3

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X directfb"

REQUIRED_USE="^^ ( X directfb )"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        virtual/pkgconfig
        X? ( x11-libs/gtk+:2[X] )
        directfb? ( x11-libs/gtk+:2[directfb] )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
    use X && emake TARGET=x11 GDK_WINDOWING=X11
    use directfb && emake TARGET=directfb GDK_WINDOWING=DIRECTFB
}

src_install() {
    use X && emake install PREFIX=/usr DESTDIR=${D} TARGET=x11
    use directfb && emake install PREFIX=/usr DESTDIR=${D} TARGET=directfb
}
