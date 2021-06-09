#!/bin/sh
# shellcheck shell=dash source=/dev/null
# .bash_profile

umask 022

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
