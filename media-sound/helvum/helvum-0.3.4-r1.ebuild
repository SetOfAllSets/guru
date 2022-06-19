# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.15
	ansi_term-0.12.1
	anyhow-1.0.53
	arrayvec-0.5.2
	atty-0.2.14
	autocfg-1.0.1
	bindgen-0.59.2
	bitflags-1.3.2
	bitvec-0.19.6
	cairo-rs-0.15.1
	cairo-sys-rs-0.15.1
	cc-1.0.72
	cexpr-0.6.0
	cfg-expr-0.8.1
	cfg-expr-0.9.1
	cfg-if-0.1.10
	cfg-if-1.0.0
	clang-sys-1.3.0
	clap-2.34.0
	cookie-factory-0.3.2
	either-1.6.1
	env_logger-0.9.0
	errno-0.2.8
	errno-dragonfly-0.1.2
	field-offset-0.3.4
	funty-1.1.0
	futures-channel-0.3.19
	futures-core-0.3.19
	futures-executor-0.3.19
	futures-io-0.3.19
	futures-task-0.3.19
	futures-util-0.3.19
	gdk-pixbuf-0.15.4
	gdk-pixbuf-sys-0.15.1
	gdk4-0.4.6
	gdk4-sys-0.4.2
	gio-0.15.4
	gio-sys-0.15.4
	glib-0.15.4
	glib-macros-0.15.3
	glib-sys-0.15.4
	glob-0.3.0
	gobject-sys-0.15.1
	graphene-rs-0.15.1
	graphene-sys-0.15.1
	gsk4-0.4.6
	gsk4-sys-0.4.2
	gtk4-0.4.6
	gtk4-macros-0.4.3
	gtk4-sys-0.4.5
	heck-0.3.3
	heck-0.4.0
	hermit-abi-0.1.19
	humantime-2.1.0
	itertools-0.10.3
	lazy_static-1.4.0
	lazycell-1.3.0
	lexical-core-0.7.6
	libc-0.2.116
	libloading-0.7.3
	libspa-0.4.1
	libspa-sys-0.4.1
	log-0.4.14
	memchr-2.3.4
	memoffset-0.6.5
	minimal-lexical-0.2.1
	nix-0.14.1
	nom-6.2.1
	nom-7.1.0
	once_cell-1.9.0
	pango-0.15.2
	pango-sys-0.15.1
	peeking_take_while-0.1.2
	pest-2.1.3
	pin-project-lite-0.2.8
	pin-utils-0.1.0
	pipewire-0.4.1
	pipewire-sys-0.4.1
	pkg-config-0.3.24
	proc-macro-crate-1.1.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.36
	quote-1.0.15
	radium-0.5.3
	regex-1.4.6
	regex-syntax-0.6.25
	rustc-hash-1.1.0
	rustc_version-0.3.3
	ryu-1.0.9
	semver-0.11.0
	semver-parser-0.10.2
	serde-1.0.136
	shlex-1.1.0
	signal-0.7.0
	slab-0.4.5
	smallvec-1.8.0
	static_assertions-1.1.0
	strsim-0.8.0
	strum-0.21.0
	strum_macros-0.21.1
	syn-1.0.86
	system-deps-3.2.0
	system-deps-6.0.1
	tap-1.0.1
	termcolor-1.1.2
	textwrap-0.11.0
	thiserror-1.0.30
	thiserror-impl-1.0.30
	toml-0.5.8
	ucd-trie-0.1.3
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	vec_map-0.8.2
	version-compare-0.0.11
	version-compare-0.1.0
	version_check-0.9.4
	void-1.0.2
	which-4.2.4
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	wyz-0.2.0
"

inherit cargo desktop

DESCRIPTION="A GTK patchbay for pipewire"
HOMEPAGE="https://gitlab.freedesktop.org/pipewire/helvum"
SRC_URI="
	https://gitlab.freedesktop.org/pipewire/helvum/-/archive/${PV}/${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="Apache-2.0 BSD GPL-3 ISC MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/glib-2.66:2
	>=gui-libs/gtk-4.4.0:4
	media-libs/graphene
	media-video/pipewire:=
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
"

src_install() {
	cargo_src_install

	dodoc README.md

	doicon --size scalable data/icons/org.pipewire.Helvum.svg

	insopts -m 0644
	insinto /usr/share/icons/hicolor/symbolic/apps
	doins data/icons/org.pipewire.Helvum-symbolic.svg

	make_desktop_entry "${PN}" Helvum org.pipewire.Helvum "AudioVideo;Audio;Video;Midi;Settings;GNOME;GTK" "Terminal=false\nGenericName=Patchbay"
}
