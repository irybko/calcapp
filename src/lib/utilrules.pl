%
%
%	Copyright (C) Ivan B. Rybko 
%	===========================
%	libpredicates.pl
%
:- module('utilrules',
[	
% list processing rules
	firstelem/2, 
	lastelem/2, 
	reverselist/2,
	copylist/2,
	insertelem/3,
	removelem/3,
	listlen/2, 
	getindex/3,
	getelem/3,
	sublist1/3,
	sublist2/3,
	sublist3/3,
	listempty/1,
	eqlists/2,
	permutation/2, 
	intersection/2,
	intersection/4,
% string processing rules
	trim/2,
	stringempty/1,
	charstocodes/2,
	checksubstring/2,
	strlen/2,
% stream processing rules
	tostream/2,
	getstream/2,
	getstream/3,
	clearscrn/0,
	readstdin/3 
]).

%
% first element
%
firstelem(L, E) :- [E|_] = L. 
%
% last element
%
lastelem(L, E) :- 
	listlen(L, N), 
	N == 1, 
	[E|_] = L; 
	[_|T] = L, 
	lastelem(T, E),
	!. 
%
% reversing list
%
reverselist([],[]).
reverselist([H|T], L) :- 
	reverselist(T,Z), 
	append(Z, [H], L). 
%
% copy list
%
copylist([],[]).
copylist(L1, L2) :- 
	[X|Y] = L1,
	[X|Z] = L2,
	Z = Y.
%
% insert element to end of list
%
insertelem( E, [], [E]).
insertelem( E, [H|T], [H|R]) :- insertelem(E, T, R). 
%
%	remove element by index
%
removelem(Index, List, Result) :- 
	getelem(Index, List, Elem), 
	select(Elem, List, Result). 
%
% get list length
%
listlen([],0).
listlen([_|T], N) :- 
	listlen(T, K), 
	N is K+1.
%
% get index by an element
%
getindex(Index, List, Elem) :- 
	nth0(Index, List, Elem),!. 
%
% get elem by index
%
getelem(Index, List, Elem) :- 
	Index >= 0, getindex(Index, List, Elem);	
	Index <  0, listlen(List, Len),	
			Pstn is Len + Index,
			Pstn > 0, 
			getindex(Pstn, List, Elem).
%
% 	sublist
%
sublist1(L, E, [Left|Right]) :- 
	append(Left, [E|Right], L),!.

sublist2(L, Index, [Left|Right]) :- 
	getelem(Index, L, E), 
	sublist1(L, E, [Left|Right]).

sublist3(L, Delim, [Left|Right]) :-
	sublist1(L, Delim, [Left|Temp]),
	append([Delim], Temp, Right).

%
%	check empty sequence
%
listempty(L) :- 
	is_list(L), 
	L \= [] -> fail;!.
%
%	check equality of lists
%
eqlists([],[]).
eqlists([],_L2).
eqlists(_L1,[]).
eqlists(L1, L2) :- 
	L1 == L2, 
	write("Lists are equal") ; write("Lists are not equal"), fail.
%
%	permutation
%
permutation([],[]).
permutation(L, [H|T]) :- 
	append(V, [H|U], L), 
	append(V, U, W), 
	permutation(W, T).
%
%	occurs intersection between two lists
%
intersection(List, SubList) :- 
	listlen(SubList, SLNum),
	[First|Remainder] = SubList,
	( member(First, List) -> Count is Count + 1; 
		Count is Count - 1
	),!,
	intersection(List, Remainder),
	Count == SLNum.

intersection(List, SubList, Positive, Negative) :-
	[First|Remainder] = SubList,
	( member(First, List) -> 
		append([], [First], Positive);
		append([], [First], Negative)
	),!,
	intersection(List, Remainder, Positive, Negative).

%===========================================================
%	string processing rules
%===========================================================
%
%	string trim  
%
trim(S1, S2) :- 
	split_string(S1, " ","", L), 
	atomics_to_string(L, S2).
%
%	stringempty
%
stringempty(Es) :- 
	string(Es), 
	string_codes(Es, L), 
	listempty(L).

%
%	chars to codes
%
charstocodes(L, Codes) :-
	[H|T] = L,
	char_code(H, HCode),
	append([], [HCode], Codes),
	charstocodes(T, Codes).
%
%	check substring 
%
checksubstring(Substring, Fullstring) :-
	string(Substring),
	string(Fullstring),
	string_codes(Substring, SSCodes),
	string_codes(Fullstring, FSCodes),
	intersection(SSCodes, FSCodes).

%
% get string length 
%
strlen("",0).
strlen(S, N) :-
	string(S),
	string_codes(S, TempCodes),
	listlen(TempCodes, N),
	N > 0.

%========================================================
%	stream processing rules
%========================================================
%
%	clear screen 
%
clearscrn :- put(27), write("[2J"), put(27), write("[H").
%
%	read string from stdin
%
readstdin(Declaration, Sep, Exprt) :-
	write(Declaration),	
	read_line_to_codes(user_input, Cs), 
	char_code(Sep, SepCode),
	select(SepCode, Cs, Lst), 
	string_codes(Expr, Lst),
	trim(Expr, Exprt),	
	( stringempty(Exprt) -> 
		write("Expression is empty string"), 
		nl, 
		fail;!
	),
	( Exprt == "quit" -> 
		halt;! 
	).
%
%	write to stream
%
tostream("","").
tostream([],"").
tostream(List, Path) :-
	open(Path, write, OutStream),
	write(OutStream, List).

tostream("").
tostream([]).
tostream(Line) :- string(Line),	write(Line).
tostream([Line|Rest]) :- tostream(Line), tostream(Rest).	
%
%	read from stream
%
getstream("","").
getstream(Path, List) :- 
	exists_file(Path),
	open(Path, read, InStream),
	read(InStream, List),
	close(InStream). 

getstream(Path, Sz, Line) :-
	exists_file(Path),
	integer(Sz),
	open(Path, read, In), 
	read_string(In, Sz, Line).

