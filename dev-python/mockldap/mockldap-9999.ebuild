# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit mercurial distutils-r1

DESCRIPTION="A simple mock implementation of python-ldap"
HOMEPAGE="http://bitbucket.org/psagers/mockldap/ https://pypi.python.org/pypi/mockldap"
EHG_REPO_URI="https://bitbucket.org/psagers/mockldap/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="dev-python/funcparserlib[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/python-ldap[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	esetup.py test
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}

pkg_postinst() {
	if ! has_version dev-python/passlib; then
		elog "Please install dev-python/passlib for hashed password support."
	fi
}
