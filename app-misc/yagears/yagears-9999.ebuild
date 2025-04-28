# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Yet Another Gears OpenGL / Vulkan demo"
HOMEPAGE="https://github.com/caramelli/yagears"
EGIT_REPO_URI="https://github.com/caramelli/yagears.git"
inherit git-r3 meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gl X xcb directfb fbdev drm wayland waffle rpi vk-d2d efl fltk glfw glut gtk2 gtk3 qt4 qt5 sdl1 sdl2 sfml wx png tiff"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	dev-build/meson"

RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    local emesonargs=(
        -Dengine-ctor=true
        $(meson_use gl)
        $(meson_use gl glesv1_cm)
        $(meson_use gl glesv2)
        $(meson_use X gl-x11)
        $(meson_use directfb gl-directfb)
        $(meson_use fbdev gl-fbdev)

        $(meson_use X egl-x11)
        $(meson_use directfb egl-directfb)
        $(meson_use fbdev egl-fbdev)
        $(meson_use wayland egl-wayland)
        $(meson_use xcb egl-xcb)
        $(meson_use drm egl-drm)
        $(meson_use rpi egl-rpi)
        $(meson_use waffle)

        $(meson_use X vk-x11)
        $(meson_use directfb vk-directfb)
        $(meson_use fbdev vk-fbdev)
        $(meson_use wayland vk-wayland)
        $(meson_use xcb vk-xcb)
        $(meson_use vk-d2d)

        $(meson_use efl)
        $(meson_use fltk)
        $(meson_use glfw)
        $(meson_use glut)
        $(meson_use sfml)
        $(meson_use wx)

        $(meson_use png)
        $(meson_use tiff)
    )

    if use gtk2 || use gtk3; then
        emesonargs+=( -Dgtk=true )
        use gtk2 && emesonargs+=( -Dwith-gtk=2 )
        use gtk3 && emesonargs+=( -Dwith-gtk=3 )
    fi

    if use qt4 || use qt5; then
        emesonargs+=( -Dqt=true )
        use qt4 && emesonargs+=( -Dwith-qt=4 )
        use qt5 && emesonargs+=( -Dwith-qt=5 )
    fi

    if use sdl1 || use sdl2; then
        emesonargs+=( -Dsdl=true )
        use sdl1 && emesonargs+=( -Dwith-sdl=1 )
        use sdl2 && emesonargs+=( -Dwith-sdl=2 )
    fi

    meson_src_configure
}

src_install() {
    meson_src_install
}
