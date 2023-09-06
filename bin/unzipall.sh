#!/bin/bash
find . -iname '*.zip' -exec sh -c 'unzip -o -d "${0%.*}" "$0"' '{}' ';'
