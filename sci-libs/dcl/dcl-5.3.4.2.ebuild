# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic

DESCRIPTION="C DCL scientific library"
HOMEPAGE="http://www.gfd-dennou.org/arch/dcl/"
SRC_URI="http://www.gfd-dennou.org/arch/dcl/${P}-C.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-C"

src_prepare()
{
	epatch "${FILESDIR}/${PN}-qa-ldflags.patch"
}

src_configure()
{
	append-flags -fPIC
	econf --prefix "${D}usr"
}

src_compile()
{
	# Parallel build is not supported
	make || die "Make failed"
}

src_install()
{
	# Parallel install is not supported
	make install || die "Install failed"
}
