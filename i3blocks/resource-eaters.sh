#!/bin/bash

echo -n "TOPCPU $(ps -e -ww --format %cpu=,comm= --sort=-%cpu | head -n 1)"
echo ", TOPMEM $(ps -e -ww --format %mem=,comm= --sort=-%mem | head -n 1)"
