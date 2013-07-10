# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-ldapdb/django-ldapdb-0.1.0_p20120424.ebuild,v 1.3 2012/05/20 11:54:44 tampakrap Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

EGIT_REPO_URI="https://github.com/tampakrap/django-ldapdb.git"
EGIT_BRANCH=okupy

inherit distutils-r1 git-2

DESCRIPTION="An LDAP database backend for Django"
HOMEPAGE="http://opensource.bolloretelecom.eu/projects/django-ldapdb/"
SRC_URI=""

KEYWORDS="~amd64 ~x86"
IUSE="examples test"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${PN}"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

# Tests require LDAP setup.
RESTRICT=test
