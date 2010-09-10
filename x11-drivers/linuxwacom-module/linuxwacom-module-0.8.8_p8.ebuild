# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools toolchain-funcs linux-mod

MY_PN="linuxwacom"
DESCRIPTION="Input driver for Wacom tablets and drawing devices"
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

wacom_check() {
	if use modules ; then
		ebegin "Checking for wacom module"
		linux_chkconfig_module TABLET_USB_WACOM
		eend $?

		if [[ $? -ne 0 ]] || ! [ -f "/lib/modules/${KV}/kernel/drivers/input/tablet/wacom.ko" ]; then
			eerror "You need to have your kernel compiled with wacom as a module"
			eerror "to let linuxwacom overwrite it."
			eerror "Enable it in the kernel, found at:"
			eerror
			eerror " Device Drivers"
			eerror "    Input device support"
			eerror "        Tablets"
			eerror "            <M> Wacom Intuos/Graphire tablet support (USB)"
			eerror
			eerror "(in the "USB support" page it is suggested to include also:"
			eerror "EHCI , OHCI , USB Human Interface Device+HID input layer)"
			eerror
			eerror "Then recompile kernel. Otherwise, remove the module USE flag."
			die "Wacom not compiled in kernel as a module!"
		fi
	fi
}

pkg_setup() {
	linux-mod_pkg_setup
	# wacom_check
	# echo "kernel version is ${KV} , name is ${KV%%-*}"
	ewarn "Versions of linuxwacom >= 0.7.9 require gcc >= 4.2 to compile."
}

src_unpack() {
	unpack ${A}
	cd "${S}"

#	eautoreconf
}

src_compile() {
	unset ARCH
	./configure --enable-wacom || die "econf failed"

	#emake || die "emake failed."
}

src_install() {
	# Inelegant attempt to work around a nasty build system
	cp "${S}"/src/*/wacom.{o,ko} "${S}"/src/
	linux-mod_src_install
}
