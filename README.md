[![Continuous Integration](https://github.com/chrissicool/gentoo-ovl/workflows/CI/badge.svg)](https://github.com/chrissicool/gentoo-ovl/actions?query=workflow%3ACI)

# gentoo-ovl

This is chrissicool's private ebuild collection.

## Usage

Add this to `/etc/portage/repos.conf/gentoo-ovl.conf`:

```
[gentoo-ovl]
location = /var/db/repos/gentoo-ovl/
sync-type = git
sync-uri = https://github.com/chrissicool/gentoo-ovl.git
auto-sync = yes
```

or using `app-eselect/eselect-repository`, just run the following command:

```
eselect repository add gentoo-ovl git https://github.com/chrissicool/gentoo-ovl.git
```

or install using `app-portage/layman` with the following command:

```
layman -o https://raw.github.com/chrissicool/gentoo-ovl/master/overlay.xml -f -a gentoo-ovl
```
