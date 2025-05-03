# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="standalone libkms"
HOMEPAGE="https://github.com/stefan11111/libkms"
EGIT_REPO_URI="https://github.com/stefan11111/libkms.git"
inherit git-r3 multilib-minimal

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="video_cards_vmware video_cards_intel video_cards_nouveau video_cards_radeon video_cards_exynos"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        x11-libs/libdrm[${MULTILIB_USEDEP}]
        "
RDEPEND="${DEPEND}"
BDEPEND=""

multilib_src_compile() {
    local emakeargs=()

    use video_cards_vmware && emakeargs+=(vmware=1)
    use video_cards_intel && emakeargs+=(intel=1)
    use video_cards_nouveau && emakeargs+=(nouveau=1)
    use video_cards_radeon && emakeargs+=(radeon=1)
    use video_cards_exynos && emakeargs+=(exynos=1)

    use abi_x86_32 && CFLAGS="${CFLAGS} -m32"

    emake "${emakeargs}"
}

multilib_src_install() {
    if use abi_x86_64; then
        emake install PREFIX=/usr DESTDIR=${D}
    fi
    if use abi_x86_32; then
        emake clean
        emake install PREFIX=/usr DESTDIR=${D} LIBDIR=/lib
    fi
}
