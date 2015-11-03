# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit python

DESCRIPTION="Highly efficient file backup system based on the git packfile format"
HOMEPAGE="https://github.com/bup/bup"
if [[ ${PV} != *9999* ]]; then
  SRC_URI="https://github.com/bup/${PN}/archive/${PV/_/-}.tar.gz -> ${P}.tar.gz"
  KEYWORDS="~amd64 ~x86"
else
  inherit git-2
  EGIT_REPO_URI="git://github.com/bup/bup.git"
  KEYWORDS=""
fi

LICENSE="LGPL-2"
SLOT="0"
IUSE="acl attr +doc fuse parity"

DEPEND="dev-lang/python:2.7
        >=dev-vcs/git-1.5.3.1
        attr? ( dev-python/pyxattr )
        acl? ( dev-python/pylibacl )
        fuse? ( dev-python/fuse-python )
        doc? ( app-text/pandoc )
        parity? ( app-arch/par2cmdline )"

RDEPEND="${DEPEND}"

DOCS="README CODINGSTYLE DESIGN"

src_unpack() {
  if [[ ${PV} != *9999* ]]; then
	unpack "${A}"
	mv *-${PN}-* "${S}"
  else
	git-2_src_unpack
  fi
}

pkg_setup() {
  python_set_active_version 2
}

src_configure() {
  true
}
