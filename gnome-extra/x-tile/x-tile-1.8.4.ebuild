# Copyright 1999-2010 Tiziano Müller
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"

inherit multilib distutils

DESCRIPTION="Gnome applet that allows you to select a number of windows and tile them in different ways."
HOMEPAGE="http://www.giuspen.com/x-tile/"
SRC_URI="http://www.giuspen.com/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/pygtk:2
	dev-python/gconf-python
	dev-python/gnome-applets-python
	dev-python/pygobject"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e '/subprocess.call/d' \
		setup.py || die "sed failed"
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}/modules/*.py

	elog "You may have to restart gnome-panel."
	elog "Either logout/login or do 'pkill gnome-panel' to trigger a restart."
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}/modules/
}

