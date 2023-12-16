# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Dummy python 3.11 package to satisfy broken deps"
HOMEPAGE=""

LICENSE="GPL-3"
SLOT="3.11"
KEYWORDS="~amd64 ~x86"
IUSE="
        bluetooth build debug +ensurepip examples gdbm libedit lto
        +ncurses pgo +readline +sqlite +ssl test tk valgrind
"

DEPEND=""
RDEPEND=""
BDEPEND=""
