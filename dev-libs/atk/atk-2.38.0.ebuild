# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Minimal implementation of Gnome Accessibility Toolkit "
HOMEPAGE="https://github.com/stefan11111/atk"
EGIT_REPO_URI="https://github.com/stefan11111/atk.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
                dev-libs/glib:2"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
} 
