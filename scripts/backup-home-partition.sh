#!/usr/bin/env bash


sudo tar -czvf ./archive.tar.gz \
--exclude='*cache*' \
--exclude='*Cache*' \
--exclude=/home/mojo/shared \
--exclude=.cargo \
--exclude=anaconda3 \
--exclude=.anaconda3 \
--exclude=.npm \
--exclude='*/node_modules' \
--exclude='*/node' \
--exclude='*/venv' \
--exclude='*/target' \
--exclude=.debug \
--exclude=.dbus \
--exclude=.gvfs \
--exclude=.local/share/gvfs-metadata \
--exclude=.rustup \
--exclude=.local/share/Trash \
--exclude=Downloads \
--exclude=archive.tar.gz \
--exclude=/home/shared/distros \
/home
