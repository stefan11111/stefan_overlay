# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="OpenGL ES 2.0 GFX driver"
HOMEPAGE="https://github.com/directfb2/DirectFB2-gles2"
EGIT_REPO_URI="https://github.com/directfb2/DirectFB2-gles2.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	virtual/directfb"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    meson_src_configure
}

src_install() {
    meson_src_install
}
