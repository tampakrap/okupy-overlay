# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit mercurial distutils-r1

DESCRIPTION="A simple mock implementation of python-ldap"
HOMEPAGE="http://bitbucket.org/psagers/mockldap/"
EHG_REPO_URI="https://bitbucket.org/psagers/mockldap/"

KEYWORDS=""
IUSE="+passlib"

LICENSE="BSD"
SLOT="0"

DEPEND="dev-python/python-ldap[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	passlib? ( dev-python/passlib[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}"

python_test() {
	cd "src/mockldap/ldap" || die
	${PYTHON} -m unittest tests
	echo "$@"
	"$@" || die "Tests failed with ${EPYTHON}"
}
