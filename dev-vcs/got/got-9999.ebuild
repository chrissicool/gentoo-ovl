# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A version control system which prioritizes ease of use and simplicity."
HOMEPAGE="http://gameoftrees.org/"
LICENSE="ISC"

inherit autotools

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.gameoftrees.org/got-portable.git"
	EGIT_BRANCH="portable"
else
	SRC_URI="https://gameoftrees.org/releases/portable/${PN}-portable-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="0"

BDEPEND="(
	virtual/pkgconfig
)"
DEPEND="(
	app-crypt/libmd
	dev-libs/libbsd
	dev-libs/libevent
	sys-libs/ncurses
	sys-libs/zlib
)"

src_prepare() {
	default
	PREFIX="${EPREFIX}/usr" \
		eautoreconf --prefix="${EPREFIX}/usr"
}
