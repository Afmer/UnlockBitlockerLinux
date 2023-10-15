#!/bin/bash

recovery_password="$1"
device="nvme0n1p1"

sudo $PWD/bashScripts/baseScript.sh $recovery_password $device