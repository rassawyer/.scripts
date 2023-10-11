#!/bin/bash
#
find /home/rassawyer/Media/ -type d -print -exec sudo chmod 777 {} \;

find /home/rassawyer/Media/ -type f  -print -exec sudo chmod 666 {} \;

