# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8
DESCRIPTION="Header needed to build xorg without mesa"
HOMEPAGE="https://github.com/stefan11111/dri_interface.h"
EGIT_REPO_URI="https://github.com/stefan11111/dri_interface.h.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
BDEPEND=""

src_install() {
    emake install DESTDIR=${D}
}
