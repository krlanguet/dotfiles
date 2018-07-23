/* manifest.js */

/*
 * WARNING : The function which generates the unlinking list does not respect host/package specifications.
 *
 * Disable the exported unlink list, and manually perform unlinking if using any such specifications.
 *
 */


'use strict'

const homedir = 'home/keith/'

const config = 'home/keith/.config/'

const dotfiles = __dirname + '/'

// Prefix for all (non-link) source paths
const originRoot = '/'

// Prefix for all destination paths.
const targetRoot = '/'

// Package lookup backend to use:
const pkgType = 'pacman'

// I/O backend to use:
const ioType = 'linux'

const defaults = {
    user: 'keith',
    group: 'keith'
}

// Directories to be synchronised
const directories = [
    {
        src: dotfiles + '5-terminal/fish',
        dst: 'root/.config/fish',
        user: 'root',
        group: 'root',
    }
]

// Files to be copied
const files = [
    {
        src: dotfiles + '0-hardware/backlight',
        dst: 'etc/X11/xorg.conf.d/10-backlight.conf',
        user: 'root',
        group: 'root',
        fmode: '644'
    },
    {
        src: dotfiles + '0-hardware/fstab',
        dst: 'etc/fstab',
        user: 'root',
        group: 'root',
        fmode: '644'
    },
    {
        src: dotfiles + '0-hardware/touchpad',
        dst: 'etc/X11/xorg.conf.d/20-touchpad.conf',
        user: 'root',
        group: 'root',
        fmode: '644'
    },
    {
        src: dotfiles + 'wpa_config-untracked',
        dst: 'etc/wpa_supplicant/wpa_supplicant-wlp1s0.conf',
        user: 'root',
        group: 'root',
        fmode: '644'
    },
    {
        src: dotfiles + '1-system/fuse',
        dst: 'etc/fuse.conf',
        user: 'root',
        group: 'root',
        fmode: '644'
    },
    {
        src: dotfiles + '1-system/journald',
        dst: 'etc/systemd/journald.conf',
        user: 'root',
        group: 'root',
        fmode: '644'
    },
    {
        src: dotfiles + '1-system/mkinitcpio',
        dst: 'etc/mkinitcpio.conf',
        user: 'root',
        group: 'root',
        fmode: '644'
    },
    {
        src: dotfiles + '2-packages/mirrorlist',
        dst: 'etc/pacman.d/mirrorlist',
        user: 'root',
        group: 'root',
        fmode: '644'
    },
    {
        src: dotfiles + '2-packages/pacman',
        dst: 'etc/pacman.conf',
        user: 'root',
        group: 'root',
        fmode: '644'
    },
    {
        src: dotfiles + '3-X/key_symbols',
        dst: 'usr/share/X11/xkb/symbols/us',
        user: 'root',
        group: 'root',
        fmode: '644'
    },
    {
        src: dotfiles + '3-X/key_types',
        dst: 'usr/share/X11/xkb/types/pc',
        user: 'root',
        group: 'root',
        fmode: '644'
    },
    {
        src: dotfiles + 'scripts/setXDG.sh',
        dst: 'etc/profile.d/setXDG.sh',
        user: 'root',
        group: 'root',
        fmode: '755'
    }
]

// Symbolic links to be created
const symlinks = [
    {
        dst: dotfiles + '2-packages/defaults',
        src: config + 'mimeapps.list'
    },
    {
        dst: dotfiles + '3-X/Xresources',
        src: homedir + '.Xresources'
    },
    {
        dst: dotfiles + '5-terminal/fish',
        src: config + 'fish'
    },
    {
        dst: dotfiles + '5-terminal/fonts',
        src: config + 'fontconfig/fonts.conf'
    },
    {
        dst: dotfiles + '6-runcoms/calibre',
        src: config + 'calibre'
    },
    {
        dst: dotfiles + '6-runcoms/git',
        src: config + 'git/config'
    },
    {
        dst: dotfiles + '6-runcoms/nvim',
        src: config + 'nvim'
    },
    {
        dst: dotfiles + '6-runcoms/termite',
        src: config + 'termite/config'
    },
    {
        dst: dotfiles + '6-runcoms/zotero',
        src: homedir + '.zotero'
    },
    {
        dst: dotfiles + 'scripts',
        src: config + 'scripts'
    },
    {
        dst: dotfiles + 'scripts/xinitrc',
        src: homedir + '.xinitrc'
    },
    {
        dst: dotfiles + '4-i3',
        src: config + 'i3'
    }
]

// WARNING : This function does not respect package installation or host !!
function generate_unlinks() {
    var unlinks = []
    for (var i = 0; i < directories.length; i++) {
        var u = directories[i].dst
        unlinks.push({ src: u })
    }

    for (var i = 0; i < files.length; i++) {
        u = files[i].dst
        unlinks.push({ src: u })
    }

    for (var i = 0; i < symlinks.length; i++) {
        u = symlinks[i].src
        unlinks.push({ src: u })
    }
    return unlinks;
}

// I used the unlinks list to remove any symbolic links that might misdirect installation of the stored configs
const unlinks = generate_unlinks()

module.exports = {
    originRoot,
    targetRoot,
    pkgType,
    ioType,
    defaults,
    unlinks, // Uncomment this line if using package or host specifications
    directories,
    files,
    symlinks
}
