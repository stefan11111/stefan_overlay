# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="vrms port for gentoo"
HOMEPAGE="https://github.com/stefan11111/vrms-gentoo"
SRC_URI="https://github.com/stefan11111/${PN}/archive/refs/tags/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    mkdir -p ${D}/usr/bin
    cp vrms-gentoo ${D}/usr/bin
}
