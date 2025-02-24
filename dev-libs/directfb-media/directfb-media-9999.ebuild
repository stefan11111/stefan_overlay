# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Additional DirectFB font/image/music/video providers "
HOMEPAGE="https://github.com/directfb2/DirectFB2-media"
EGIT_REPO_URI="https://github.com/directfb2/DirectFB2-media.git"
inherit git-r3 meson multilib-minimal

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avif bmp ffmpeg freetype fusionsound gdkpixbuf gif gstreamer heif imlib2 jasper jpeg jxl libmpeg3 lodepng mad mng nanosvg openexr playlist plm png sft spng stb svg swfdec tiff tremor v4l vorbis webp yuv"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson
	virtual/directfb
	avif? ( media-libs/libavif )
	ffmpeg? ( media-video/ffmpeg )
	freetype? ( media-libs/freetype )
	gdkpixbuf? ( x11-libs/gdk-pixbuf )
	gstreamer? ( media-libs/gstreamer )
	heif? ( media-libs/libheif )
	imlib2? ( media-libs/imlib2 )
	jasper? ( media-libs/jasper )
	jpeg? ( media-libs/libjpeg-turbo )
	jxl? ( media-libs/libjxl )
	libmpeg3? ( media-libs/libmpeg3 )
	mad? ( media-libs/libmad )
	mng? ( media-libs/libmng )
	nanosvg? ( media-libs/nanosvg )
	openexr? ( media-libs/openexr )
	png? (  media-libs/libpng )
	sft? ( media-libs/libschrift )
	spng? ( media-libs/libspng )
	stb? ( dev-libs/stb )
	svg? ( x11-libs/cairo )
	tiff? ( media-libs/tiff )
	tremor? ( media-libs/libvorbis )
	vorbis? ( media-libs/libvorbis )
	webp? ( media-libs/libwebp )"

RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

multilib_src_configure() {
    local emesonargs=(
        $(meson_use avif)
        $(meson_use bmp)
        $(meson_use ffmpeg)
        $(meson_use freetype ft2)
        $(meson_use fusionsound)
        $(meson_use gdkpixbuf)
        $(meson_use gif)
        $(meson_use gstreamer)
        $(meson_use heif)
        $(meson_use imlib2)
        $(meson_use jasper)
        $(meson_use jpeg)
        $(meson_use jxl)
        $(meson_use libmpeg3)
	$(meson_use lodepng)
	$(meson_use mad)
	$(meson_use mng)
	$(meson_use nanosvg)
	$(meson_use openexr)
	$(meson_use playlist)
	$(meson_use plm)
	$(meson_use png)
	$(meson_use sft)
	$(meson_use spng)
	$(meson_use svg)
	$(meson_use swfdec)
	$(meson_use tiff)
	$(meson_use tremor)
	$(meson_use v4l)
	$(meson_use vorbis)
	$(meson_use webp)
	$(meson_use yuv)
    )

    meson_src_configure
}

multilib_src_compile() {
    meson_src_compile
}

multilib_src_install() {
    meson_src_install
}
