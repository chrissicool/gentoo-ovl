# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..10} )

inherit autotools python-single-r1

DESCRIPTION="A command-line tool and library to read and convert trace files"
HOMEPAGE="https://babeltrace.org/"
if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.efficios.com/babeltrace.git"
	EGIT_BRANCH="master"
else
	MY_P="${PN}2-${PV}"
	SRC_URI="https://www.efficios.com/files/${PN}/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-2"
SLOT="2"
IUSE="test python doc"
RESTRICT="!test? ( test )"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="dev-libs/glib:2
	dev-libs/popt
	dev-libs/elfutils
	sys-apps/util-linux
	python? ( ${PYTHON_DEPS} )
	"

DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	doc? ( app-doc/doxygen )
	python? ( >=dev-lang/swig-2.0.0 )
	"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	default
	[[ ${PV} == *9999* ]] && eautoreconf
}

src_configure() {
	econf \
		$(use_enable test glibtest) \
		$(use_enable python python-bindings) \
		$(use_enable python python-plugins) \
		$(use python && use_enable doc python-bindings-doc) \
		$(use_enable doc doxygen-doc) \
		$(use_enable doc api-doc) \
		--enable-debug-info
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die

	use python && python_optimize
}
