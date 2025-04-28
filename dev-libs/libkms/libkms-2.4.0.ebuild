# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Old kms management library"
HOMEPAGE="https://gitlab.com/neonkingfr/libdrm/-/commit/2b997bb4bb688be00620887c8646ff24ccb9396b"
EGIT_REPO_URI="https://gitlab.com/neonkingfr/libdrm.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    local emesonargs=( -Dlibkms=true )
    meson_src_configure
}

src_install() {
    meson_src_install

    mkdir -p ${D}/safe
    mkdir -p ${D}/safe/lib64
    mkdir -p ${D}/safe/include
    mkdir -p ${D}/safe/share/doc
    mkdir -p ${D}/safe/lib64/pkgconfig

    cp -r ${D}/usr/lib64/libkms* ${D}/safe/lib64
    cp -r ${D}/usr/include/libkms ${D}/safe/include/libkms
    cp -r ${D}/usr/share/doc/libkms-2.4.0 ${D}/safe/share/doc/libkms-2.4.0
    cp -r ${D}/usr/lib64/pkgconfig/libkms.pc ${D}/safe/lib64/pkgconfig/libkms.pc

    rm -rf ${D}/usr/*
    cp -r ${D}/safe/* ${D}/usr
    rm -rf ${D}/safe
}
