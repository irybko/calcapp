%
% get string length 
%

strlen("",0).
strlen(S, N) :-
	string_codes(S, Codes),
	listlen(Codes, N).

%
%	string trim  
%
%

trim(S1, S2) :-
	strsplit(S1, " ", L),
	atomics_to_string(L, S2).

% 	splitting a line on several strings
%

strsplit("", "", []).
strsplit(Line, Sep, List) :-
	split_string(Line,Sep,"",List).

%
%	chars to codes
%

charstocodes(L, Codes) :-
	[H|T] = L,
	char_code(H, HCode),
	append([], [HCode], Codes),
	charstocodes(T, Codes).


