# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Rubinius is an implementation of the Ruby programming language"
HOMEPAGE="http://rubini.us"
SRC_URI="http://asset.rubini.us/${PN}-1.0.0-rc1-20091125.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-1.0.0-rc1"

src_configure() {
	./configure
#	emake || die "emake failed"
}

src_compile() {
	rake build
}

src_install() {
	rake install
}
