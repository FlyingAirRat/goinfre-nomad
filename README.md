# goinfre-nomad, a system service that leverages the volatile local directory ~/goinfre to seamlessly use space-hogging apps across any node in the 42 cluster.

## Introduction
goinfre-nomad is a service that leverages the volatile local ~/goinfre to seamlessly use space-hogging apps across any node in the 42 cluster.
Inspired by [42free](https://github.com/itislu/42free).

## Why use it?
Due to the nature of the cluster, installing apps under user privileges often causes directories like `.local`, `.config`, `.cache`, and `.var` under the home directory to run out of space. Among these, `.local` is used for app installations, `.config` for app settings, `.cache` for app caches, and `.var` for app data storage.
Rather than storing all app components under the home directory, it was determined that keeping only the essential components (such as app configurations) in the home directory, and placing re-installable app binaries and cache files in goinfre on every login, is a more effective solution to the storage problem.

## How it works
The goinfre-nomad systemd service performs two main functions:
- On logout, it saves the list of apps installed via flatpak with the `--user` option to `~/.config/goinfre-nomad/installed-apps.txt`.
- On login:
	1. Creates the `~/goinfre/goinfre-nomad` directory.
	2. Removes the `~/.local/share/flatpak` directory and symlinks `~/goinfre/goinfre-nomad/flatpak` to `~/.local/share/flatpak`.
	3. Runs `flatpak remote-add --user flathub --if-not-exists --url=https://flathub.org/repo/flathub.flatpakrepo` to add the flathub remote repository on a per-user basis.
	4. Runs `flatpak repair --user` to verify the integrity of apps already installed in the goinfre-nomad directory and recover files if necessary.
	5. Installs each app saved in `~/.config/goinfre-nomad/installed-apps.txt` with the `--user` option.

## Installation
1. Clone the goinfre-nomad repository.
   ```bash
   git clone
   ```

2. Run the install script using the Makefile.
   ```bash
   make install
   ```
