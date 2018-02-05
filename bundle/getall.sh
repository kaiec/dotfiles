#!/bin/bash
grep -v "#" plugins.txt | while read i; do git submodule add $i; done;
