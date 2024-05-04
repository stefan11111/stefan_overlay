# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Audio subsystem using Fusion IPC "
HOMEPAGE="https://github.com/directfb2/FusionSound2"
EGIT_REPO_URI="https://github.com/directfb2/FusionSound2.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa filter multichannel oss ieee-floats"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	virtual/directfb"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    local emesonargs=(
        $(meson_use alsa)
        $(meson_use filter linear-filter)
        $(meson_use multichannel)
        $(meson_use oss)
        $(meson_use ieee-floats)
    )

    meson_src_configure
}

src_install() {
    meson_src_install
}
