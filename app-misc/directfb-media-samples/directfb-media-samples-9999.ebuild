# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="amples and test programs for DirectFB media providers"
HOMEPAGE="https://github.com/directfb2/DirectFB-media-samples"
EGIT_REPO_URI="https://github.com/directfb2/DirectFB-media-samples.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	virtual/directfb
	dev-libs/directfb-media"

RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    meson_src_configure
}

src_install() {
    meson_src_install
}
