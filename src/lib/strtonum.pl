%
%	strtonum - convert string to number
%
:- [utilrules].
%
strtonum(NumStrExpr, Number) :-
	string_codes(NumStrExpr, SCodes), 
	[First|_] = SCodes,
	( First == 45 -> 
		select(First, SCodes, RemList), codestonum(RemList, Step), Number is 0 - Step; 
		codestonum(SCodes, Number)
	),!.

codestonum(StrCodes, Num) :-
	char_code('.', DotCode),
	( member(DotCode, StrCodes) -> 	
		sublist1(StrCodes, DotCode, [WCodes|FCodes]),
		getwholenumber(WCodes, WNum), getfractnumber(FCodes, FNum), 
		getresultnumber(WNum, FNum, Num);
	  getwholenumber(StrCodes, Num)	
	),!.
%
%	get whole number from numbers list	
%
getwholenumber(CharCodes, WN) :- 
	charstodigits(CharCodes, WDigitCodes), digtonumlist(WDigitCodes, NumList),listsumm(NumList, WN).
%
%	get fract number from number`s list
%
getfractnumber(CharCodes, FN) :- 
	listlen(CharCodes, Sz),	getwholenumber(CharCodes, WNum),digtonum(WNum, -Sz, FN).
%
%	get result as summ of whole part and fract part of number
%
getresultnumber(WN, FN, RN) :-	RN is WN + FN.
%
%	charstodigits converts digits chars into digits list
%
charstodigits([], []).
charstodigits(CharList, [Num|L]) :-
	[H|T] = CharList, chartodigit(H, Num), charstodigits(T, L).

chartodigit(ChCode, Num) :- ChCode >= 48, ChCode =< 57, Num is ChCode - 48.
%
%	converts digit to numbers list
%
digtonum(Digit, Power, Num) :- Num is Digit * 10 ** Power.
%
digtonumlist([],_).
digtonumlist([H|T], NumList) :-
	listlen(T, Len), digtonum(H, Len, Num1), digtonumlist(T, Num2),	append([Num1], Num2, NumList).
%
%	sum_list
%
listsumm([], 0).
listsumm([H|T], Sum) :- listsumm(T, Rest), Sum is H + Rest.
%
% 	check number by odd or even
%
checknum(N, Odd, Even) :-
	N1 is N // 2, 
	N2 is N - N1 * 2, 
	( N2 > 0 -> Odd = true, Even = false; 
	  N2 == 0 -> Even = true, Odd = false 
	),!.

