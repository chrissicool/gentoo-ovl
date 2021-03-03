# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A version control system which prioritizes ease of use and simplicity over flexibility."
HOMEPAGE="http://gameoftrees.org/"
LICENSE="ISC"

inherit autotools

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://git.gameoftrees.org/got-portable.git"
    EGIT_BRANCH="linux"
else
    eerror "There is no stable release for portable got, yet."
fi

KEYWORDS="~amd64"
IUSE=""
SLOT="0"

RESTRICT=""

BDEPEND="(
    virtual/pkgconfig
)"
DEPEND="(
    app-crypt/libmd
    dev-libs/libbsd
    sys-libs/ncurses
    sys-libs/zlib
)"

src_prepare() {
	default
	PREFIX="${EPREFIX}/usr" \
	    eautoreconf --prefix="${EPREFIX}/usr"
}
