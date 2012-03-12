# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit python

DESCRIPTION="Simple minifier for JSON to remove comments and whitespace"
HOMEPAGE="https://github.com/getify/JSON.minify"
SRC_URI="https://github.com/getify/JSON.minify/tarball/master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/getify-JSON.minify-697465d"

src_install() {
	installation() {
		insinto $(python_get_sitedir)
		doins minify_json.py
	}
	python_execute_function -q installation

	dodoc README.txt
}
