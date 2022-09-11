%
%  calcapp  
%
:- consult('checking.pl').
:- consult('strtonum.pl').
:- consult('listpreds.pl').
:- consult('strpreds.pl').
%
%	run shell mode
%
run  :- 
	write("Type any infix arithmetic expressions with +,-,/,* operators"),nl,
	write("At the end of expression type ';'"),nl,
	write("For exit type quit;"), nl, nl,
	repeat,
	readstdin("Expr> ", ";", Expr),
	stmnt(Expr),
	fail.
%
%	read string from stdin
%
readstdin(Declaration, Sep, Expr) :-
	write(Declaration),	
	read_line_to_codes(user_input, Cs), 
	char_code(Sep, SepCode),
	select(SepCode, Cs, Lst), 
	string_codes(Expr, Lst).
%
%	stmnt	takes some arithmetical expression and return result of compution.
%
stmnt(Es) :-
	trim(Es, Expr),
	(
		stringempty(Expr) ->
			write("Expression is empty string"), nl, fail;!
	),
	(
		Expr == "quit" -> halt;!
	),
	checkop(Expr, OpCode),
	string_codes(Expr, ExprCodes), 
	sublist1(ExprCodes, OpCode, [LeftCodes|RightCodes]),
	strtonum(LeftCodes, LNum),
	strtonum(RightCodes, RNum),
	compute(OpCode, LNum, RNum), nl,!.
%
%	compute
%
compute(OpCode, LNum, RNum) :- 
	OpCode == 43 -> Res is LNum + RNum, write("Result ": Res);
	OpCode == 45 -> Res is LNum - RNum, write("Result ": Res);
	OpCode == 47 -> Res is LNum / RNum, write("Result ": Res);
	OpCode == 42 -> Res is LNum * RNum, write("Result ": Res);
	char_code(Op, OpCode), write("Unknown operator ": Op);
	!.
