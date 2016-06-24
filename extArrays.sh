#!/bin/bash

#####################
#       INIT        #
#####################

shopt -s expand_aliases

# Just so we keep track of how many we have.
# This has the shortcomming that we do never delete arrays.
__ARRAY_COUNT__=0

#####################
# Private Functions #
#####################

__ARRAY_HANDLER__ () {
	local var=$1; shift
	local expr="$@"
	local index newExpr content
	
	# Next element is an index - like '[0]' - continue with recursion
	if [[ $expr =~ ^\ *\[([0-9]*)\](.*) ]]; then
		index=${BASH_REMATCH[1]}
		newExpr=${BASH_REMATCH[2]}
		__ARRAY_GENERATE__ $var
		__ARRAY_HANDLER__ "$(eval "echo \${$var}")[$index]" "$newExpr"
		
	# Next element is an assignment - like '= blah' - this breaks the recursion
	elif [[ $expr =~ ^\ *=\ *(.*) ]]; then
		eval "$var=${BASH_REMATCH[1]}"
		
	# No next element, so we switch to printing the variable instead - this breaks the recursion
	elif [[ $expr =~ ^\ *$ ]]; then
		echo "$(eval "echo \${$var}")"
		
	# Ooops
	else
		echo "syntax error in multi-dimensional array" >&2
	fi
}

__ARRAY_GENERATE__ () {
	if [[ -z $(eval "echo \${$var}") ]]; then
		eval "$1=__ARRAY__$__ARRAY_COUNT__"
		((__ARRAY_COUNT__++))
	fi
}

__ARRAY_TESTER__ () {
	array multid
	
	multid [65535][0] = 20
	multid [65535][1] = 30
	
	dumper multid
	
	dumper asd
	asd=zxc
}

####################
# Public Functions #
####################

# Perl Data::Dumper style dumping of the contents of the whole array
arrayDumper () {
	local pointer=$1
	
	local content="$(eval "echo \${$pointer}")"
	local key
	
	local indent="$2"
	if [[ -z $indent ]]; then
		echo -n "$pointer = "
	fi
	
	if [[ $(declare -p $content 2> /dev/null) =~ ^declare\ -a ]]; then
		echo "{"
		for key in $(eval "echo \${!$content[@]}"); do
			echo -n "    $indent$key = "
			dumper $content[$key] "    "
		done
		echo "$indent}"
	else
		echo "'$content'"
	fi
}

# Associate the new name with the array handler function
array () {
	alias $1="__ARRAY_HANDLER__ $1"
}

