# Systematically Process Args And Stdin In Bash Commands

This is an example of a bash command capable of getting its inputs from 
both the command line arguments and from th stdin. This is a commonly desired 
design pattern.

The processArgsAndStdin.sh is an Interactive Command Module (ICM).
if you don't wish to adopt the ICM framework, just lift the code 
in vis_processInputs and eliminate the famework facilities.

The design pattern in vis_processInputs involves the following:

- processEach -- A nested function in vis_processInputs

	This where you put your code.
	It expects a single argument that you then process.
	
- processArgsAndStdin -- A nested function in vis_processInputs

    You should consider this function as read-only and don't touch it.
	The magic of combining args and stdin and applying them to processEach
	happens here.
	
	Notable features of processArgsAndStdin are:
	
	* if [ ! -t 0 ] ; then -- deals with stdin and converts it to args with readarray.
	* effectiveArgs is combination of $@ and stdin as args.
    * ${each%$'\n'} strips newline of stdin args
    * $@ and ${effectiveArgs[@]} should be quoted
	
	In the ICM framework this code is an emacs-org-mode-dynamic-block.
	The lisp code for bx:bsip:bash/processArgsAndStdin  is part of Blee.
	
- invocation of processArgsAndStdin with vis_processInputs's inputs.

In order to execute processArgsAndStdin.sh as an Interactive Command Module (ICM),

- sudo apt-get -y install python3-pip  # if needed
- sudo pip3 install --upgrade bisos.bashStandaloneIcmSeed
  This results in creation of /usr/local/bin/seedIcmStandalone.bash
  which processArgsAndStdin.sh depends on.
- git clone https://github.com/bxexamples/bashProcessArgsAndStdin.git
- run processArgsAndStdin.sh and choose the desired command line from examples.


  
