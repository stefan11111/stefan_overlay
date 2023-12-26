# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="dummy gdbus-codegen implementation useful when building gtk3"
HOMEPAGE="https://github.com/stefan11111/minimal-gtk3"
EGIT_REPO_URI="https://github.com/stefan11111/minimal-gtk3.git"
inherit git-r3

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
}
