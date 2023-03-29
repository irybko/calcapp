%
%  calcapp  
%
:- consult('lib/compute.pl').
:- consult('lib/checking.pl').
:- consult('lib/strtonum.pl').
:- [lib/utilrules].
%
%	run shell mode
%
run_v1 :- 
	write("Type any infix arithmetic expressions with +,-,/,* operators"),nl,
	write("At the end of expression type ';'"),nl,
	write("For exit type quit;"), nl, nl,
	repeat,
	readstdin("Expr> ", ";", Expr),
	stmnt_v1(Expr),
	fail.
%
%	stmnt	takes some arithmetical expression and return result of compution.
%
stmnt_v1(Es) :-
	checkop(Es, OpCode),
	string_codes(Es, ExprCodes), 
	sublist1(ExprCodes, OpCode, [LeftCodes|RightCodes]),
	strtonum(LeftCodes, LNum),
	strtonum(RightCodes, RNum),
	compute(OpCode, LNum, RNum), nl,!.


