# $NetBSD$

DISTNAME=	espeakng-loader-0.2.4
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	audio python
MASTER_SITES=	${MASTER_SITE_GITHUB:=thewh1teagle/}
GITHUB_PROJECT=	espeakng-loader
# No tag for 0.2.4: "bump version to 0.2.4" plus the LICENSE file.
GITHUB_TAG=	0ddc87adf77e5850d7eeb542ac8a87d421b64daa

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/thewh1teagle/espeakng-loader
COMMENT=	Locate the eSpeak NG library and data from Python
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-hatchling-[0-9]*:../../devel/py-hatchling
DEPENDS+=	espeak-ng-[0-9]*:../../audio/espeak-ng

USE_LANGUAGES=	# none

# The PyPI wheels bundle their own espeak-ng build; point at pkgsrc's.
SUBST_CLASSES+=		espeak
SUBST_STAGE.espeak=	pre-configure
SUBST_MESSAGE.espeak=	Using pkgsrc's espeak-ng library and data.
SUBST_FILES.espeak=	src/espeakng_loader/__init__.py
SUBST_SED.espeak=	-e "s|Path(__file__).parent / lib_name|Path('${PREFIX}/lib') / lib_name|"
SUBST_SED.espeak+=	-e "s|Path(__file__).parent / 'espeak-ng-data'|Path('${PREFIX}/share/espeak-ng-data')|"

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
