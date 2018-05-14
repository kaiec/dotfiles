#!/bin/bash
[[ -e ~/.is_presentation ]] || (khal list `date +%H:%M` 3h | grep ^[012] --color=never || echo '') | head -n 2 | paste -sd '%' - | sed 's/%/ | /'
