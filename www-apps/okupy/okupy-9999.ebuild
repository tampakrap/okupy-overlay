# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite?"

inherit git-2 webapp distutils-r1

DESCRIPTION="Django LDAP webUI and OpenID provider for the Gentoo Project"
HOMEPAGE="http://github.com/gentoo/identity.gentoo.org"
EGIT_REPO_URI="git://github.com/gentoo/identity.gentoo.org"

KEYWORDS=""
IUSE="mysql postgres sqlite test"
LICENSE="AGPL-3"
SLOT="0"

DEPEND=">=dev-python/setuptools-0.6.30[${PYTHON_USEDEP}]
	test? (
		>=dev-python/django-discover-runner-1.0[${PYTHON_USEDEP}]
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		=dev-python/mockldap-9999[${PYTHON_USEDEP}]
	)"
RDEPEND="${DEPEND}
	>=dev-python/django-1.5[${PYTHON_USEDEP},mysql?,postgres?,sqlite?]
	>=dev-python/django-auth-ldap-1.1.4[${PYTHON_USEDEP}]
	>=dev-python/django-compressor-1.3[${PYTHON_USEDEP}]
	>=dev-python/django-ldapdb-9999[${PYTHON_USEDEP}]
	>=dev-python/django-otp-9999[${PYTHON_USEDEP}]
	>=dev-python/edpwd-0.0.7[${PYTHON_USEDEP}]
	>=dev-python/paramiko-1.10.1[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.13[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.13[${PYTHON_USEDEP}]
	>=dev-python/python-ldap-2.4.10[${PYTHON_USEDEP}]
	>=dev-python/python-openid-2.2.5[${PYTHON_USEDEP}]
	>=dev-python/qrcode-3.0[${PYTHON_USEDEP}]"

REQUIRED_USE="|| ( mysql postgres sqlite )
	test? ( sqlite )"

WEBAPP_MANUAL_SLOT="yes"

python_test() {
	set -- ${PYTHON} manage.py test --settings=okupy.tests.settings tests
	echo "$@"
	"$@" || die "Tests failed with ${EPYTHON}"
}

src_install() {
	webapp_src_preinst
	distutils-r1_src_install

	python_export ${PYTHON_COMPAT} PYTHON EPYTHON PYTHON_SITEDIR

	local settings_dir="${PYTHON_SITEDIR}/${PN}/settings"

	# copy local.py.sample to local.py
	insinto ${settings_dir}
	newins ${ED}${settings_dir}/local.py.sample local.py
	# remove useless sample files
	rm ${ED}${settings_dir}/*.sample || die
	# create bytecode files for the newly created local.py
	python_optimize ${ED}${settings_dir}
	# symlink to /etc/okupy.conf for convenience
	dosym ${settings_dir}/local.py /etc/okupy.conf

	webapp_src_install
}

pkg_postinst() {
	elog "A copy of the admin media is available to webapp-config for installation in a"
	elog "webroot, as well as the traditional location in python's site-packages dir"
	elog "for easy development."
	webapp_pkg_postinst
}
