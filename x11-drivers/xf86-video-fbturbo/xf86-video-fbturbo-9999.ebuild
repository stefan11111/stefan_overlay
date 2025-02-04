# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools git-r3

DESCRIPTION="Xorg DDX driver for ARM devices (Allwinner, RPi and others)"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~alpha amd64 arm ~arm64 ~hppa ~loong ~m68k ~mips ppc ppc64 ~riscv sparc x86"

EGIT_REPO_URI="https://github.com/KenjiBrown/xf86-video-fbturbo.git"
EGIT_BRANCH="aarch64-gentoo"

DEPEND="x11-base/xorg-proto
        x11-libs/xorg-macros"
RDEPEND="${DEPEND}
	x11-base/xorg-server"

src_prepare() {
    eapply ${FILESDIR}/fix-build-2025.patch
    default
    eautoreconf
}

src_configure() {
    econf
}

src_compile() {
    emake
}

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
}

