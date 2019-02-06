#!/bin/bash

#########################################################
# Simple scripts to fix pulseaudio media keys           #
# misbehavior after the computer comes back from sleep. #
#                                                       #
#                 PLEASE RUN AS A ROOT                  #
#########################################################

set -o errexit

if [[ $EUID -ne 0 ]]; then
    printf "\n  Not being run as $(tput bold)root! \n $(tput sgr0) \n  Please, check privileges... \n\n" 
    exit 1
fi

if [ ! -d "/etc/acpi" ]; then
    printf "  Missing acpi folder in /etc\n"
    exit 1
fi

if [ ! -d "/etc/acpi/actions" ]; then
    printf "  Creating new folder: /etc/acpi/actions\n"
    mkdir /etc/acpi/actions
fi

if [ ! -d "/etc/acpi/events" ]; then
    printf "  Creating new folder: /etc/acpi/events\n"
    mkdir /etc/acpi/events
fi

printf "\n  Copying files...\n"

cp acpi_files/volume /etc/acpi/actions/
cp acpi_files/volume_down /etc/acpi/events/
cp acpi_files/volume_up /etc/acpi/events/

printf "\n  Restarting $(tput bold)acpid.service$(tput sgr0)\n"

systemctl restart acpid.service

printf "\n  Done! Enjoy =D\n\n"
