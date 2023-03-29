%
% calcpreds - calcapp specific predicates library	
%
:- [utilrules].
%
%	compute
%
compute(OpCode, LNum, RNum) :- 
	OpCode == 43 -> Res is LNum + RNum, writeln("Result ": Res);
	OpCode == 45 -> Res is LNum - RNum, writeln("Result ": Res);
	OpCode == 47 -> Res is LNum / RNum, writeln("Result ": Res);
	OpCode == 42 -> Res is LNum * RNum, writeln("Result ": Res);
	char_code(Op, OpCode), writeln("Unknown operator ": Op);
	!.

