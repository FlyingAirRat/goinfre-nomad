#!/bin/bash

mkdir -p ~/.config/goinfre-nomad
flatpak list --user --app --columns=application > ~/.config/goinfre-nomad/installed-apps.txt
