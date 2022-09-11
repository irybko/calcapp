%
% first element
%

firstelem(L, E) :- [E|_] = L.

%
% last element
%

lastelem(L, E) :- 
	listlen(L, N),
	N == 1 -> 
		[E|_] = L; 
		[_|T] = L,
		lastelem(T, E).
%
%	reversing list
%

rev([],[]).
rev([H|T], L) :- 
	rev(T,Z), 
	append(Z, [H], L).

%
%	copy list
%

copylist([],[]).
copylist(L1, L2) :- 
	[X|Y] = L1, 
	[X|Z] = L2, 
	Z = Y.

%
%	insert element to end of list
%

insert( E, [], [E]).
insert( E, [H|T], [H|R]) :-
   insert(E, T, R).

%
%	remove element by index
%

rmvelem(Index, List, Result) :-
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
% get index from list by elem
%

getindex(Index, List, Elem) :-
	nth0(Index, List, Elem).

%
% get elem by index
%

getelem(Index, List, Elem) :-
	Index >= 0, 
	getindex(Index, List, Elem);
	Index <  0, 
	listlen(List, Len),
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

%
%	check empty sequence
%

listempty(L) :-
	is_list(L),
	L \= [] -> fail;!.

stringempty(Es) :-
	string(Es),
	string_codes(Es, L),
	listempty(L).
%
%	check equality of lists
%
eqlists([],[]).
eqlists([],_L2).
eqlists(_L1,[]).
eqlists(L1, L2) :-
	L1 == L2 -> write("Lists are equal");write("Lists are not equal"),fail.

