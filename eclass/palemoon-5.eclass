inherit check-reqs gnome2-utils toolchain-funcs xdg-utils desktop

EXPORT_FUNCTIONS pkg_pretend pkg_preinst pkg_postinst pkg_postrm pkg_setup


###
# Package
###

palemoon-5_pkg_pretend() {
	# Ensure that we have enough disk space to compile:
	CHECKREQS_DISK_BUILD=${REQUIRED_BUILDSPACE}
	check-reqs_pkg_setup
}

palemoon-5_pkg_preinst() {
	gnome2_icon_savelist
}

palemoon-5_pkg_postinst() {
	# Update mimedb for the new .desktop file:
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

palemoon-5_pkg_postrm() {
	gnome2_icon_cache_update
}

palemoon-5_pkg_setup() {
	# Nested configure scripts in mozilla products generate unrecognized
	# options false positives when toplevel configure passes downwards:
	export QA_CONFIGURE_OPTIONS=".*"
}


###
# Messages
###

official-branding_warning() {
	elog "You are enabling the official branding. You may not redistribute this build"
	elog "to any users on your network or the internet. Doing so puts yourself into"
	elog "a legal problem with Moonchild Productions."
	elog "You can disable the official branding by emerging ${PN} _without_"
	elog "the official-branding USE flag."
}


###
# Configuration
###

mozconfig_init() {
	echo "ac_add_options --enable-application=palemoon" > "${S}/.mozconfig"
}

mozconfig_enable() {
	for option in "$@"; do
		echo "ac_add_options --enable-${option}" >> "${S}/.mozconfig"
	done
}

mozconfig_disable() {
	for option in "$@"; do
		echo "ac_add_options --disable-${option}" >> "${S}/.mozconfig"
	done
}

mozconfig_with() {
	for option in "$@"; do
		echo "ac_add_options --with-${option}" >> "${S}/.mozconfig"
	done
}

mozconfig_var() {
	echo "mk_add_options $1=$2" >> "${S}/.mozconfig"
}

set_pref() {
	echo "pref(\"$1\", $2);" >> "${S}/${obj_dir}/dist/bin/browser/defaults/preferences/palemoon.js"
}


###
# Branding
###

install_branding_files() {
	cp -rL "${S}/${obj_dir}/dist/branding" "${extracted_dir}/"
	local size sizes icon_path icon name
	sizes="16 32 48"
	icon_path="${extracted_dir}/branding"
	icon="${PN}"
	name="Pale Moon"
	for size in ${sizes}; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps"
		newins "${icon_path}/default${size}.png" "${icon}.png"
	done
	# The 128x128 icon has a different name:
	insinto "/usr/share/icons/hicolor/128x128/apps"
	newins "${icon_path}/mozicon128.png" "${icon}.png"
	# Install a 48x48 icon into /usr/share/pixmaps for legacy DEs:
	newicon "${icon_path}/default48.png" "${icon}.png"
	newmenu "${FILESDIR}/icon/${PN}.desktop" "${PN}.desktop"
	sed -i -e "s:@NAME@:${name}:" -e "s:@ICON@:${icon}:" \
		"${ED}/usr/share/applications/${PN}.desktop" || die
}
