# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual to select between different DirectFB providers"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"
IUSE="directfb2"

RDEPEND="
    directfb2? ( dev-libs/DirectFB2 )
    !directfb2? ( dev-libs/DirectFB )
"
