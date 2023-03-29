%
% calcapp  
%
:- consult('lib/compute.pl').
:- consult('lib/checking.pl').
:- use_module(library(dcg/basics)).
%
%	run shell mode
%
run_v3 :- 
	write("Type any infix arithmetic expressions with +,-,/,* operators"),nl,
	write("At the end of expression type ';'"),nl,
	write("For exit type quit;"), nl, nl,
	repeat,
	readstdin("Expr> ", ";", Expr),
	stmnt_v3(Expr),
	fail.
%
%	stmnt	takes some arithmetical expression and return result of compution.
%
stmnt_v3(Es) :- atom_codes(Es, EsCodes),phrase(expr, EsCodes),!.
%
%	DCG based rule description of accessible expression grammar
%
expr    --> lnum(Ln),sign(OpCode),rnum(Rn),{ compute(OpCode,Ln,Rn) }. 
%
lnum(N, In, OutCodes) :-
	checkop(In, OpCode),
	sublist3(In, OpCode, [NumCodes|OutCodes]), 
	number_string(N, NumCodes).

sign(Opc, In, Out) :- 
	[ Opc|Out ] = In. 

rnum(N, In, []) :- 
	number_string(N, In).

