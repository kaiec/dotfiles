#!/bin/bash

function _shortcut_comp_master {
	local current_word=${COMP_WORDS[$COMP_CWORD]}
	if [[ $current_word == "#bla" ]]; then
		COMPREPLY=("~/Downloads")
		return
	fi
	$1
}

command=$1
echo "Enable shortcuts on $command"
completions=$(complete -p $command)
echo "Current completions: $completions"
func=$(echo $completions | awk '{for (I=1;I<=NF;I++) if ($I == "-F") {print $(I+1)};}')
if [[ $func =~ "_shortcut_comp" ]]; then
	echo "Shortcuts already enabled"
	return
fi
echo "Function used: $func"
definition=$(echo $completions | sed s/'\w*$//')
echo "Definition: " $definition
suffix=$(date +'%Y%m%d%H%M%S%N')
eval "function _shortcut_comp_$suffix { _shortcut_comp_master $func; }"
eval "$definition -F _shortcut_comp_$suffix $command"
