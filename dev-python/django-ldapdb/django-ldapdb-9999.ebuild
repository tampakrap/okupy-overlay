# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

EGIT_REPO_URI="https://github.com/tampakrap/django-ldapdb.git"
EGIT_BRANCH=okupy

inherit distutils-r1 git-2

DESCRIPTION="An LDAP database backend for Django"
HOMEPAGE="https://github.com/tampakrap/django-ldapdb/"
SRC_URI=""

KEYWORDS=""
IUSE="examples"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${PN}"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/mockldap[${PYTHON_USEDEP}] )"

python_test() {
	# 'examples' tests are still work-in-progress
	python manage.py test ldapdb || die "Tests fail with ${EPYTHON}"
}
