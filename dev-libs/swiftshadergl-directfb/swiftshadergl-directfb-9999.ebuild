# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="CPU-based implementation of OpenGL ES and EGL for DirectFB platform "
HOMEPAGE="https://github.com/directfb2/SwiftShaderGL-DirectFB"
EGIT_REPO_URI="https://github.com/directfb2/SwiftShaderGL-DirectFB.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="named-mmap pool-alloc"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	virtual/directfb"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    local emesonargs=(
        $(meson_use named-mmap)
        $(meson_use pool-alloc)
    )

    meson_src_configure
}

src_install() {
    meson_src_install
}
