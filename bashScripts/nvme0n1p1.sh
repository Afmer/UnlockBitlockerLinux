#!/bin/bash

local_path=$(dirname "$(readlink -f "$0")")
recovery_password="$1"
device="nvme0n1p1"

sudo $local_path/baseScript.sh $recovery_password $device