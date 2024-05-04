# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Data header file generation utility for DirectFB code"
HOMEPAGE="https://github.com/directfb2/directfb-csource"
EGIT_REPO_URI="https://github.com/directfb2/directfb-csource.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="directfb png"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	directfb? ( virtual/directfb )
	png? ( media-libs/libpng )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    local emesonargs=(
        $(meson_use directfb)
        $(meson_use png)
    )

    meson_src_configure
}

src_install() {
    meson_src_install
}
