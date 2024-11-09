# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-2.0_pre4-r1.ebuild,v 1.1 2004/12/27 00:04:04 cyfred Exp $

EAPI=8

DESCRIPTION="Utility to change the OpenGL interface being used"
HOMEPAGE="http://www.gentoo.org/"
GLEXT="20040830"
SRC_URI="http://dev.gentoo.org/~cyfred/distfiles/glext.h-${GLEXT}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	app-arch/bzip2"

pkg_setup() {
	# xfree has glext.h somewhere out of place so lets make the user move it
	if ( [ ! -h /usr/X11R6/include/GL/glext.h ] && [ -a /usr/X11R6/include/GL/glext.h ] )
	then
		# Just make it simpler on the user by giving verbose instructions
		if [ -d /usr/lib/opengl/xfree ]
		then
			GL_IM="xfree"
		else
			GL_IM="xorg-x11"
		fi

		echo
		ewarn "Due to inconsistencies in xorg-x11 vs xfree handling of glext.h a userspace"
		ewarn "is necessary for you to use opengl-update-1.8; Please do the following"
		echo
		ewarn "mv /usr/X11R6/include/GL/glext.h /usr/lib/opengl/${GL_IM}/include"
		echo
		ewarn "You may then remerge opengl-update-1.8.1 successfully"
		echo

		die "Userspace problem needs fixing"
	fi
}

src_unpack() {
    mkdir -p ${S}
    bzcat ${DISTDIR}/glext.h-${GLEXT}.bz2 > ${WORKDIR}/glext.h || die
}

src_install() {
	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update || die

	# Install default glext.h
	mkdir -p ${D}/usr/lib/opengl/global/include
    cp ${WORKDIR}/glext.h ${D}/usr/lib/opengl/global/include
	#insinto ${D}/usr/lib/opengl/global/include
	#doins ${WORKDIR}/glext.h || die
}

pkg_postinst() {
	echo
	ewarn "This version will only work with >=x11-base/xorg-x11-6.8.0-r2."
	ewarn "Upgrade before running ${PN}."
	echo
}
