# $NetBSD$

DISTNAME=	rubicon_objc-0.5.7
PKGNAME=	${PYPKGPREFIX}-${DISTNAME:S/_/-/}
CATEGORIES=	devel python
MASTER_SITES=	${MASTER_SITE_PYPI:=r/rubicon-objc/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://beeware.org/project/projects/bridges/rubicon/
COMMENT=	Bridge between Objective-C and Python
LICENSE=	modified-bsd

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools_scm-[0-9]*:../../devel/py-setuptools_scm

USE_LANGUAGES=	# none

# Talks to the Objective-C runtime through ctypes.
ONLY_FOR_PLATFORM=	Darwin-*-*

PYTHON_VERSIONS_INCOMPATIBLE=	310 # requires-python >= 3.11

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
