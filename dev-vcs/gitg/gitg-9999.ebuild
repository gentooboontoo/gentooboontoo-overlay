# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

#inherit autotools gnome2 git
inherit gnome2 git

DESCRIPTION="git repository viewer for GNOME"
HOMEPAGE="http://wiki.github.com/jessevdk/gitg"
SRC_URI=""

EGIT_REPO_URI="git://git.gnome.org/gitg"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.16
	>=x11-libs/gtksourceview-2.2
	>=gnome-base/gconf-2.10
	dev-vcs/git"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.15
	>=dev-util/intltool-0.35"

src_prepare() {
#	./autogen.sh || die "Autogen script failed"
#	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	./autogen.sh --prefix /usr
}

#src_unpack() {
#	gnome2_src_unpack
#}

#pkg_postinst() {
#	gnome2_pkg_postinst
#	ewarn "This version of gitg is an unstable development snapshot."
#	ewarn "Please report any problems at http://trac.novowork.com/gitg ."
#}
