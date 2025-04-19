# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Map frame from USB camera to Linux framebuffer"
HOMEPAGE="https://github.com/caramelli/v4l2-framebuffer"
EGIT_REPO_URI="https://github.com/caramelli/v4l2-framebuffer.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
    emake
}

src_install() {
    mkdir -p ${D}/usr/bin
    cp ${S}/${P} ${D}/usr/bin/v4l2-framebuffer
}
