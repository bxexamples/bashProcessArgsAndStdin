#!/bin/bash

IcmBriefDescription="A minimal but complete example for a bash command capable of accepting inputs from args and stdin."

ORIGIN="
* Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGINNOT: bx:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGINNOT: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] | 
"
FILE="
*  /This File/ :: /bisos/git/bxRepos/bxexamples/bashProcessArgsAndStdin/processArgsAndStdin.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /usr/local/bin/seedIcmStandalone.bash -l $0 "$@" 
    exit $?
fi
####+END:

function vis_examples {
    local extraInfo="-h -v -n showRun"

    visLibExamplesOutput ${G_myName} 
    cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Cmnd Line Args" )
${G_myName} -i processInputs arg1 "arg2 including spaces"
${G_myName} ${extraInfo} -i processInputs arg1 "arg2 including spaces"
$( examplesSeperatorChapter "Stdin Input" )
printf "stdin1 with spaces\nstdin2\n" | ${G_myName} -i processInputs
printf "stdin1 with spaces\nstdin2\n" | ${G_myName} ${extraInfo} -i processInputs
$( examplesSeperatorChapter "Stdin Input And Cmnd Line Args" )
printf "stdin1 with spaces\nstdin2\n" | ${G_myName} -i processInputs arg1 "arg2 including spaces"
printf "stdin1 with spaces\nstdin2\n" | ${G_myName} ${extraInfo} -i processInputs arg1 "arg2 including spaces"
_EOF_
}

function noArgsHook {
    vis_examples
}


function vis_processInputs {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Function description.
Design Pattern: processEach based on args and stdin.
Examples:
      ${G_myName} -i ${G_thisFunc} someArg1 someArg2
      printf "someStdin1\nsomeStdin2\n" | ${G_myName} -i ${G_thisFunc} someArg1 someArg2
_EOF_
    }
    local thisFunc=${G_thisFunc}

    function processEach {
	EH_assert [[ $# -eq 1 ]]
	local each="$1"

	lpDo echo "Processing ${thisFunc}:: ${each}"	

	lpReturn 0
    }

####+BEGIN: bx:bsip:bash/processArgsAndStdin 
     function processArgsAndStdin {
	local effectiveArgs=( "$@" )
	local stdinArgs
	local each
	if [ ! -t 0 ]; then # FD 0 is not opened on a terminal, there is a pipe
	    readarray stdinArgs < /dev/stdin
	    effectiveArgs=( "$@" "${stdinArgs[@]}" )
	fi
	if [ ${#effectiveArgs[@]} -eq 0 ] ; then
	    ANT_raw "No Args And Stdin Is Empty"
	    lpReturn
	fi
	for each in "${effectiveArgs[@]}"; do
	    lpDo processEach "${each%$'\n'}"
	done
    }
    lpDo processArgsAndStdin "$@"
####+END:
    
    lpReturn
}


####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Common        ::  /[dblock] -- End-Of-File Controls/ [[elisp:(org-cycle)][| ]]
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:
