# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit webapp

DESCRIPTION="OpenPhoto webapp: open source alternative to Flickr or Picasa"
HOMEPAGE="http://theopenphotoproject.org/"
SRC_URI="https://github.com/${PN}/frontend/tarball/${PV} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/php[crypt,curl,gd]
	virtual/httpd-php"
