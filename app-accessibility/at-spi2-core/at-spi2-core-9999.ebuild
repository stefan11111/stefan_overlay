# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8
DESCRIPTION="dummy at-spi2-code implementation"
HOMEPAGE=""

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="introspection X abi_x86_32 abi_x86_64"

DEPEND="
	<dev-libs/atk-2.46.0[X(+)?,introspection(+)?,abi_x86_32(+)?,abi_x86_64(+)?]"
RDEPEND=""
BDEPEND=""
