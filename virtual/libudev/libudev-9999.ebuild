# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib-build

DESCRIPTION="Virtual for libudev providers"

SLOT="0/1"
KEYWORDS="~alpha amd64 arm arm64 hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"
IUSE="fake"

RDEPEND="
        !fake? ( sys-fs/libudev-zero[${MULTILIB_USEDEP}] )
        fake? ( sys-fs/fake-libudev[${MULTILIB_USEDEP}] )
"
pkg_pretend() {
    use fake && ewarn "sys-fs/fake-libudev only works with a few programs"
    use fake && ewarn "You most likely want to emerge virtual/libudev with USE=-fake"
}
