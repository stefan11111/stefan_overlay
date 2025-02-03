# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Small utility to start an evdev kdrive server"
HOMEPAGE="https://github.com/stefan11111/start-kdrive"
EGIT_REPO_URI="https://github.com/stefan11111/start-kdrive.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
BDEPEND=""

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
}
