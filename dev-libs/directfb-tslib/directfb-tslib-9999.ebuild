# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="tslib input driver"
HOMEPAGE="https://github.com/directfb2/DirectFB2-tslib"
EGIT_REPO_URI="https://github.com/directfb2/DirectFB2-tslib.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	x11-libs/tslib
	virtual/directfb"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    meson_src_configure
}

src_install() {
    meson_src_install
}
