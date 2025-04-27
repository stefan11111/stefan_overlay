# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Spinning Vulkan Cube"
HOMEPAGE="https://github.com/caramelli/vkcube"
EGIT_REPO_URI="https://github.com/caramelli/vkcube.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kms xcb wayland"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	media-libs/libpng
	kms? ( x11-libs/libdrm
	       media-libs/mesa[gbm(+)]
	       dev-util/vulkan-intel-header
	)
	xcb? ( x11-libs/libxcb )
	wayland? ( dev-libs/wayland
	           dev-libs/wayland-protocols
	)
	media-libs/vulkan-loader"

RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    local emesonargs=(
        $(meson_use kms)
        $(meson_use xcb)
        $(meson_use wayland)
    )
    meson_src_configure
}

src_install() {
    mkdir -p ${D}/usr/bin
    cp ${S}-build/vkcube ${D}/usr/bin/vkcube
}
