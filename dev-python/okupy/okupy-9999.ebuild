# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite?"
WEBAPP_NO_AUTO_INSTALL="yes"

inherit git-2 webapp distutils-r1

DESCRIPTION="Django LDAP webUI and OpenID provider for the Gentoo Project"
HOMEPAGE="http://github.com/gentoo/identity.gentoo.org"
EGIT_REPO_URI="git://github.com/gentoo/identity.gentoo.org"

KEYWORDS=""
IUSE="mysql postgres sqlite test"
LICENSE="AGPL-3"
SLOT="0"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		=dev-python/mockldap-9999[${PYTHON_USEDEP}]
	)"
RDEPEND="${DEPEND}
	>=dev-python/django-1.5[${PYTHON_USEDEP}]
	~dev-python/django-auth-ldap-1.1.4.0.1[${PYTHON_USEDEP}]
	>=dev-python/django-compressor-1.3[${PYTHON_USEDEP}]
	>=dev-python/edpwd-0.0.4[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/python-ldap-2.4.10[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}"

WEBAPP_MANUAL_SLOT="yes"

python_test() {
	${PYTHON} manage.py test --settings=okupy.tests.settings tests
	echo "$@"
	"$@" || die "Tests failed with ${EPYTHON}"
}

src_install() {
	distutils-r1_src_install
	webapp_src_install
}

python_install_all() {
	distutils-r1_python_install_all

	# TODO: uncomment when okupy/static gets introduced
	#insinto "${MY_HTDOCSDIR#${EPREFIX}}"
	#doins -r okupy/static/.
}

pkg_postinst() {
	elog "A copy of the admin media is available to webapp-config for installation in a"
    elog "webroot, as well as the traditional location in python's site-packages dir"
    elog "for easy development."
    webapp_pkg_postinst
}
