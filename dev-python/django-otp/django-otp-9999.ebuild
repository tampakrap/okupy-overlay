# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
EHG_REPO_URI="https://bitbucket.org/psagers/django-otp"

inherit distutils-r1 mercurial

DESCRIPTION="One Time Passwords support for django"
HOMEPAGE="https://bitbucket.org/psagers/django-otp/"
SRC_URI=""

KEYWORDS=""
IUSE=""
LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${P}/${PN}

src_unpack() {
	# stupid eclass with its smart use of ${S}
	S=${WORKDIR}/${P} mercurial_src_unpack
}
