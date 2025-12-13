# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="libgbm is the Generic Buffer Management library, a frontend to GBM."
HOMEPAGE="https://github.com/glfs-book/libgbm"
EGIT_REPO_URI="https://github.com/glfs-book/libgbm.git"
inherit git-r3 meson multilib-minimal

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	x11-libs/libdrm"
RDEPEND="${DEPEND}"
BDEPEND=""

multilib_src_configure() {
    meson_src_configure
}

multilib_src_compile() {
    meson_src_compile
}

multilib_src_install() {
    meson_src_install
}
