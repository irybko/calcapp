%
%  calcapp  
%
:- consult('lib/compute.pl').
:- consult('lib/checking.pl').
%
%	run shell mode
%
run_v2 :- 
	write("Type any infix arithmetic expressions with +,-,/,* operators"),nl,
	write("At the end of expression type ';'"),nl,
	write("For exit type quit;"), nl, nl,
	repeat,
	readstdin("Expr> ", ";", Expr),
	stmnt_v2(Expr),
	fail.
%
%	stmnt	takes some arithmetical expression and return result of compution.
%
stmnt_v2(Es) :-
	checkop(Es, OpCode),
	string_codes(Es, ExprCodes), 
	sublist1(ExprCodes, OpCode, [LeftCodes|RightCodes]),
	%
	% number_string is the SWI-Prolog standard library rule of converting string codes representation of a number to a number, 
	% and vice versa.
	% We use it here instead of one direction strtonum rule which we made in previous version
	% 
	number_string(LNum, LeftCodes),
	number_string(RNum, RightCodes),
	compute(OpCode, LNum, RNum), nl,!.

