FROM gentoo/portage:latest as portage
FROM gentoo/stage3
LABEL maintainer="Christian Ludwig <chrissicool@gmail.com>"

WORKDIR /gentoo-ovl

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo
COPY . /gentoo-ovl

RUN mkdir -p /etc/portage/repos.conf
RUN echo -e "[gentoo-ovl]\nlocation = /gentoo-ovl\nauto-sync = no" > /etc/portage/repos.conf/gentoo-ovl
RUN echo 'ACCEPT_KEYWORDS="~${ARCH}"' >> /etc/portage/make.conf
RUN echo 'ACCEPT_PROPERTIES="* -interactive"' >> /etc/portage/make.conf
RUN echo 'EMERGE_DEFAULT_OPTS="--quiet-build --verbose"' >> /etc/portage/make.conf
