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
IUSE="crypt doc"

LICENSE="BSD"
SLOT="0"

DEPEND=">=dev-python/setuptools-0.6.30[${PYTHON_USEDEP}]"
RDEPEND="dev-python/python-ldap[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	crypt? ( dev-python/passlib[${PYTHON_USEDEP}] )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	set -- "${PYTHON}" setup.py test
	echo "${@}"
	"${@}" || die "Tests failed with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}
