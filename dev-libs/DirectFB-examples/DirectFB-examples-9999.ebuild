# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="DirectFB examples"
HOMEPAGE="https://github.com/directfb2/DirectFB-examples"
EGIT_REPO_URI="https://github.com/directfb2/DirectFB-examples.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	dev-libs/DirectFB"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    meson setup build/
}

src_compile() {
    meson compile -C build/
}

src_install() {
    meson install -C build/
}
