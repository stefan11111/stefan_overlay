# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="GTK3 port of leafpad"
HOMEPAGE="https://github.com/stevenhoneyman/l3afpad"
EGIT_REPO_URI="https://github.com/stevenhoneyman/l3afpad.git"
inherit git-r3

IUSE="print statistics xinput2 emacs search-history"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )"
RDEPEND="${DEPEND}"
BDEPEND=">=x11-libs/gtk+-3"

src_configure() {
    ./autogen.sh
        local myconf=(
        $(use_enable print print)
        $(use_enable statistics statistics)
        $(use_enable xinput2 xinput2)
        $(use_enable emacs emacs)
        $(use_enable search-history search-history)
	)
        econf "${myconf[@]}"
}

src_install() {
    emake install DESTDIR=${D}
}
