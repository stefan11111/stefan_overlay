# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Various empty files"
HOMEPAGE="https://github.com/stefan11111/various-shims"
EGIT_REPO_URI="https://github.com/stefan11111/various-shims.git"
inherit git-r3

CFLAGS="${CFLAGS}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vala xmlto itstool polkit intltool gettext dbus"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	emake DESTDIR=${D}

	if use vala; then
		emake vala DESTDIR=${D}
	fi

	if use xmlto; then
		emake xmlto DESTDIR=${D}
	fi

	if use itstool; then
		emake itstool DESTDIR=${D}
	fi

	if use polkit; then
		emake polkit DESTDIR=${D}
	fi

	if use intltool; then
		emake intltool DESTDIR=${D}
	fi

	if use gettext; then
		emake gettext DESTDIR=${D}
	fi

	if use dbus; then
		emake dbus DESTDIR=${D}
	fi
}
