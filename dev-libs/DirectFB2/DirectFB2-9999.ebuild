# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Core DirectFB library"
HOMEPAGE="https://github.com/directfb2/DirectFB2"
EGIT_REPO_URI="https://github.com/directfb2/DirectFB2.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_mmx cpu_flags_x86_neon constructors drmkms fbdev linux_input memcpy-probing multi-application multi-kernel network piped-stream sentinels smooth-scaling text trace"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson"

RDEPEND="${DEPEND}"
BDEPEND="dev-libs/flux"

src_configure() {
    local emesonargs=(
        $(meson_use constructors)
        $(meson_use drmkms)
        $(meson_use fbdev)
        $(meson_use linux_input)
        $(meson_use memcpy-probing)
        $(meson_use cpu_flags_x86_mmx mmx)
        $(meson_use cpu_flags_x86_neon neon)
        $(meson_use multi-application multi)
        $(meson_use multi-kernel)
        $(meson_use network)
        $(meson_use piped-stream)
        $(meson_use sentinels)
        $(meson_use smooth-scaling)
        $(meson_use text)
        $(meson_use trace)
    )

    meson_src_configure
}

src_install() {
    meson_src_install
}
