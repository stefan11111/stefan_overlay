# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="DirectFB Document Viewer"
HOMEPAGE="https://github.com/directfb2/Projektor"
EGIT_REPO_URI="https://github.com/directfb2/Projektor.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mupdf poppler"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	dev-libs/lite
	virtual/directfb
	mupdf? ( app-text/mupdf )
        poppler? ( app-text/poppler )"

RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    local emesonargs=(
        $(meson_use mupdf)
        $(meson_use poppler)
    )

    meson_src_configure
}

src_install() {
    meson_src_install
}
