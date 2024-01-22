# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools toolchain-funcs git-r3

DESCRIPTION="Text mode window environment"
HOMEPAGE="https://github.com/cosmos72/twin"

SRC_URI="https://github.com/cosmos72/twin/archive/refs/tags/v${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 -mips ppc ppc64 sh -sparc x86"

src_prepare() {
	default

	eautoreconf
}


src_install() {
	default
}

