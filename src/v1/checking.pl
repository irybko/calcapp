%
%	checktype rule checks argument`s data type which
%	would be an integer, float or list of integer or float.
%       Argument`s type can not be a string
%

checktype(X) :- 
	integer(X); 
	float(X).

checktype(X) :- 
	string(X), 
	write("Argument has incompatible type"), 
	halt.

checktype([H|T]) :-
	checktype(H),
	checktype(T).

checkop(Expr, OpCode) :-
	string_codes(Expr, Es),
	(
		char_code('*', OpCode),	
		member(OpCode, Es) -> 
		!;
		char_code('/', OpCode),	
		member(OpCode, Es) -> 
		!;
		char_code('+', OpCode),	
		member(OpCode, Es) -> 
		!;
		char_code('-', OpCode),	
		member(OpCode, Es) ->
		!;
		write("Operator does not found")
	),!.

