# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.freedesktop.org/stefan11111/xf86-input-mouse"
inherit xorg-3

DESCRIPTION="X.Org keyboard input driver"
if [[ ${PV} != 9999* ]]; then
    KEYWORDS="~alpha amd64 arm arm64 ~hppa ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
fi
