#!/bin/bash

mkdir -p ~/goinfre/goinfre-nomad
rm -rf ~/.local/share/flatpak
ln -s ~/goinfre/goinfre-nomad ~/.local/share/flatpak
flatpak remote-add --user flathub --if-not-exists https://flathub.org/repo/flathub.flatpakrepo
if [ -f ~/.config/goinfre-nomad/installed-apps.txt ]; then
    echo "📦 설치된 앱 리스트를 불러와 복구를 시작합니다..."
    cat ~/.config/goinfre-nomad/installed-apps.txt | xargs flatpak install --user -y --noninteractive flathub
    flatpak repair --user
    echo "✅ 모든 앱 복구 및 설치 완료!"
else
    echo "⚠️ ~/.config/goinfre-nomad/installed-apps.txt 파일을 찾을 수 없습니다."
fi
