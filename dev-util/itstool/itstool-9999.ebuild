# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8
DESCRIPTION="minimal itstool implementation"
HOMEPAGE="https://github.com/stefan11111/fake-itstool"
EGIT_REPO_URI="https://github.com/stefan11111/fake-itstool.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    emake install DESTDIR=${D}
}
