# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/phantomjs/phantomjs-1.4.1.ebuild,v 1.1 2012/01/17 16:11:50 vapier Exp $

EAPI="4"

inherit qt4-r2

DESCRIPTION="headless WebKit with JavaScript API"
HOMEPAGE="http://www.phantomjs.org/"
SRC_URI="http://phantomjs.googlecode.com/files/${P}-source.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="x11-libs/qt-webkit[qpa]"
DEPEND="${RDEPEND}"

src_unpack() {
	qt4-r2_src_unpack
	cd "${S}"
	rm -rf src/qt/
}

src_test() {
	./bin/phantomjs test/run-tests.js || die
}

src_install() {
	qt4-r2_src_install

	dobin bin/phantomjs || die
	dodoc ChangeLog README.md

	if use examples ; then
		docinto examples
		dodoc examples/* || die
	fi
}
