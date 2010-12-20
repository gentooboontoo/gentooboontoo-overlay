# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: net-misc/hotot/hotot-9999.ebuild 2010/08/25 23:31 oceanboo exp $

EAPI=2

inherit mercurial distutils

EHG_REPO_URI="https://hotot.googlecode.com/hg/"
EHG_REVISION="default"
MY_PN="hg"

DESCRIPTION="a lightweight & open source microblogging client"
HOMEPAGE="https://code.google.com/p/hotot/"
#SRC_URI=""

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/python-distutils-extra"
RDEPEND="${DEPEND}
		>=dev-lang/python-2.5
		dev-python/notify-python
		dev-python/pywebkitgtk
		dev-libs/keybinder[python]"

S=${WORKDIR}/${MY_PN}

src_install() {
	distutils_src_install
}

