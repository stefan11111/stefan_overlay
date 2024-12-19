# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Minimal NVIDIA video driver for the Xorg X server"
KEYWORDS="~amd64 ~x86"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-video-nv.git"

IUSE="xaa"

src_configure() {
	eautoreconf
	use xaa && econf --enable-xaa
	use !xaa && econf
}

src_compile() {
	emake
}

src_install() {
	emake
}
