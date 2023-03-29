#/bin/bash
swipl --goal=run 		  \
	--toplevel=halt 	  \
	--stand_alone=true 	\
	--foreign=save 		  \
	-o $1 -c $2

exit 0
