# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

DESCRIPTION="processing JSON documents with various types of comments."
HOMEPAGE="
	https://github.com/Next-Level-Software-Studio/py-jsonwc
"
SRC_URI="
	https://github.com/Next-Level-Software-Studio/py-jsonwc/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~m68k ~mips ppc ppc64 ~riscv ~s390 ~sparc x86"

RDEPEND="
	dev-python/lark[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/six[${PYTHON_USEDEP}]
		dev-python/test[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest

src_prepare() {
	distutils-r1_src_prepare

	# Create empty README.rst to satisfy setup.py
    touch "${S}/README.rst" || die

	# remove lark-parser dependency to allow painless upgrade to lark
	sed -e '/lark-parser/d' -i setup.py || die
}

src_install() {
	rm "${D}/README.rst" || die
}