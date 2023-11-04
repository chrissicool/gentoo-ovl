FROM gentoo/portage:latest as portage
FROM gentoo/stage3
LABEL maintainer="Christian Ludwig <chrissicool@gmail.com>"

WORKDIR /gentoo-ovl

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo
COPY . /gentoo-ovl
ARG NPROC

RUN mkdir -p /etc/portage/repos.conf
RUN echo -e "[gentoo]\nlocation = /var/db/repos/gentoo\nauto-sync = no" > /etc/portage/repos.conf/gentoo
RUN echo -e "[gentoo-ovl]\nlocation = /gentoo-ovl\nauto-sync = no" > /etc/portage/repos.conf/gentoo-ovl
RUN echo 'ACCEPT_KEYWORDS="~${ARCH}"' >> /etc/portage/make.conf
RUN echo 'ACCEPT_PROPERTIES="* -interactive"' >> /etc/portage/make.conf
RUN echo "EMERGE_DEFAULT_OPTS=\"--quiet-build --verbose -j ${NPROC:-1} -l ${NPROC:-1}.0\"" >> /etc/portage/make.conf
