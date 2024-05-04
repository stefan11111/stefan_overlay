# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="A collection of DirectFB utilities"
HOMEPAGE="https://github.com/directfb2/DirectFB2-tools"
EGIT_REPO_URI="https://github.com/directfb2/DirectFB2-tools.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ffmpeg freetype png"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	virtual/directfb
	ffmpeg? (media-video/ffmpeg)
	freetype? (media-libs/freetype)
	png? (media-libs/libpng)"

RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    local emesonargs=(
        $(meson_use ffmpeg)
        $(meson_use freetype ft2)
        $(meson_use png)
    )

    meson_src_configure
}

src_install() {
    meson_src_install
}
