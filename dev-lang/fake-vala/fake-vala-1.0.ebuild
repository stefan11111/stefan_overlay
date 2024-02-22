# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8
DESCRIPTION="dummy vala implementation"
HOMEPAGE=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
BDEPEND=""

src_install() {
    mkdir -p ${D}/usr/bin
    touch ${D}/usr/bin/valac
    chmod 755 ${D}/usr/bin/valac
}
