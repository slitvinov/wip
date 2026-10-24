# $NetBSD$

DISTNAME=	cli-1.124.0
PKGNAME=	${DISTNAME:S/^cli/glab/}
CATEGORIES=	devel
MASTER_SITES=	${MASTER_SITE_GITLAB:=gitlab-org/}
GITLAB_PROJECT=	cli
GITLAB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://gitlab.com/gitlab-org/cli
COMMENT=	GitLab command-line tool
LICENSE=	mit

WRKSRC=		${WRKDIR}/cli-${GITLAB_TAG}

GO_BUILD_PATTERN=	./cmd/glab
GOFLAGS=		-ldflags "-s -w -X main.version=${PKGVERSION_NOREV}"

.include "go-modules.mk"

.include "../../lang/go/go-module.mk"
.include "../../mk/bsd.pkg.mk"
