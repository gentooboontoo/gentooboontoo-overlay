# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils toolchain-funcs linux-mod autotools

# http://who-t.blogspot.com/2010/09/wacom-support-in-linux.html
MY_PN="linuxwacom"
DESCRIPTION="Kernel driver for Wacom tablets and drawing devices"
HOMEPAGE="http://linuxwacom.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${PV/_p/-}.tar.bz2"

IUSE="usb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~ppc64 x86"

RDEPEND="sys-fs/udev
	sys-libs/ncurses"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	usb? ( >=sys-kernel/linux-headers-2.6 )"
S=${WORKDIR}/${MY_PN}-${PV/_p/-}

MODULE_NAMES="wacom(input:${S}/src:${S}/src)"
BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup
}

src_prepare() {
	if [[ $(gcc-major-version) < 4 || $(gcc-minor-version) < 2 ]]; then
		die "Versions of linuxwacom >= 0.7.9 require gcc >= 4.2 to compile."
	fi
	sed '/WCM_SRC_SUBDIRS=/s: wacomxi util xdrv::' -i configure.in || die

	kernel_is ge 2 6 36 && epatch "${FILESDIR}/linuxwacom-module-2.6.36.patch"
	eautoreconf
}

# TODO: Avoid build of hal (but actually upstream is working on separation of
# modules from linuxwacom so this is really low priority).
src_configure() {
	unset ARCH
	econf \
		--enable-wacom \
		--with-kernel=${KV_OUT_DIR} \
		--disable-dependency-tracking \
		--without-x \
		--disable-xserver64 \
		--without-xlib \
		--without-xorg-sdk \
		--without-tcl \
		--without-tk \
		$(printf -- "--disable-%s " libwacom{cfg,xi} {wac,xi}dump xsetwacom wacomxrrd)
}

src_install() {
	# Inelegant attempt to work around a nasty build system
	cp src/*/wacom.{o,ko} src/ || die
	linux-mod_src_install

	insinto /etc/udev/rules.d/
	doins src/util/60-wacom.rules || die

	exeinto /lib/udev/
	doexe "${FILESDIR}"/check_driver || die
	doman "${FILESDIR}"/check_driver.1

	dodoc AUTHORS ChangeLog
}

pkg_postinst() {
	linux-mod_pkg_postinst
	ewarn "Please remove any HAL .FDI files you may"
	ewarn "previously have installed for linuxwacom."
}
