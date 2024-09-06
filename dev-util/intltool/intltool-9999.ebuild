# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8
DESCRIPTION="minimal intltool implementation"
HOMEPAGE="https://github.com/stefan11111/fake-intltool"
EGIT_REPO_URI="https://github.com/stefan11111/fake-intltool.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
    if use minimal; then
        emake minimal
    else
        emake
    fi
}

src_install() {
    emake install DESTDIR=${D}
}
