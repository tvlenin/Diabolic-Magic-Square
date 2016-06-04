diabolic([1,8,13,12,14,11,2,7,4,5,16,9,15,10,3,6]).
diabolic([1,12,7,14,8,13,2,11,10,3,16,5,15,6,9,4]).
diabolic([1,8,11,14,12,13,2,7,6,3,16,9,15,10,5,4]).
diabolic([A1,A2,A3,A4, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4]):-
A4+B3+C2+D1==34, A1+B2+C3+D4=:=34,
A1+A2+A3+A4=:=34, B1+B2+B3+B4=:=34, C1+C2+C3+C4=:=34, D1+D2+D3+D4=:=34,
A1+B1+C1+D1=:=34, A2+B2+C2+D2=:=34, A3+B3+C3+D3=:=34, A4+B4+C4+D4=:=34,
A1+A3+C1+C3=:=34, A2+A4+C2+C4=:=34, B1+B3+D1+D3=:=34, B2+B4+D2+D4=:=34,
A1+A2+B1+B2=:=34, A3+A4+B3+B4=:=34, C1+C2+D1+D2=:=34, C3+C4+D3+D4=:=34, A2+A3+B2+B3=:=34, C2+C3+D2+D3=:=34, 
A1+B1+C3+D3=:=34, A2+B2+C4+D4=:=34, A3+B3+C1+D1=:=34, A4+B4+C2+D2=:=34, A1+A2+C3+C4=:=34, A3+A4+C1+C2=:=34, B1+B2+D3+D4=:=34, B3+B4+D1+D2=:=34.



%-------------Return more than one square---------------
diabolic(A,B):- diabolic(A), reflection(A,B).
diabolic(A,B,C):- diabolic(A,B),rotation_center(A,C).
diabolic(A,B,C,D):-diabolic(A,B,C),rotation_columns(A,D).
diabolic(A,B,C,D,E):-diabolic(A,B,C,D),rotation_rows(A,E).
diabolic(A,B,C,D,E,F):-diabolic(A,B,C,D,E),convolution(A,F).
diabolic(A,B,C,D,E,F,G):-diabolic(A,B,C,D,E,F),reflection(C,G).
diabolic(A,B,C,D,E,F,G,H):-diabolic(A,B,C,D,E,F,G),rotation_center(D,H).
diabolic(A,B,C,D,E,F,G,H,I):-diabolic(A,B,C,D,E,F,G,H),rotation_columns(B,I).
diabolic(A,B,C,D,E,F,G,H,I,J):-diabolic(A,B,C,D,E,F,G,H,I),rotation_rows(B,J).
 
%---------------------SHOWALL---------------------
% Take the three basic square and operates them to produce 382 Magic Squares.
showall:- 
showallAux(
[1,8,13,12,14,11,2,7,4,5,16,9,15,10,3,6],	
[1,12,7,14,8,13,2,11,10,3,16,5,15,6,9,4],
[1,8,11,14,12,13,2,7,6,3,16,9,15,10,5,4]).

showallAux(A,B,C):-
	combinations(A),
	combinations(B),
	combinations(C).

%Show all the posible combinations of a square.
combinations(A):-
	reflection(A,Ra),
	aux(A),
	aux(Ra).

%Have the first magic squares and call all other auxiliars.
aux(A):-
	rotation_center(A,Rca),
	convolution(A,ConvA),
	rotation_center(ConvA,RcConv),
	convolution(Rca,RcaConv),
	print([Rca,ConvA,RcConv,RcaConv]),
	auxRows(A),
	auxRows(Rca),
	auxRows(ConvA),
	auxRows(RcConv),
	auxRows(RcaConv).

%Take a magic square and rotate its rows three times. (Call auxColumns)
auxRows(A):-
	rotation_rows(A,A1),
	auxColumns(A1),
	rotation_rows(A1,A2),
	auxColumns(A2),
	rotation_rows(A2,A3),
	auxColumns(A3),
	print([A1,A2,A3]).
		
%Take a magic square and rotate its columns three times.
auxColumns(A):-
	rotation_columns(A,A1),
	rotation_columns(A1,A2),
	rotation_columns(A2,A3),
	print([A1,A2,A3]).	
	
print([]).%Write in console any list.
print([X|Xs]):-
	write(X),
	nl,
	print(Xs).
 
 
%----------------------TRANSFORMATION--------------
%-------AUXILIARY ---------------
%This predicate can reverse any list of any length.
reverse_list(list,list).
reverse_list(Inputlist,Outputlist):- reverse(Inputlist,[],Outputlist). 
reverse(list,list,list).
reverse([],Outputlist,Outputlist).    
reverse([Head|Tail],List1,List2):-reverse(Tail,[Head|List1],List2).

%This predicate can rotate a list one position to the left.
rotatelist([H|T], R) :- append(T, [H], R).

%This predicate can insert one element in a determined place of a list.
ins(Val,[H|List],Pos,[H|Res]):- Pos > 1,!,Pos1 is Pos - 1, 
ins(Val,List,Pos1,Res). 
ins(Val, List, 1, [Val|List]).

%----------Reflection------------------------
%Reverse all rows of the square.
reflection([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],Z):-
	diabolic([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]),
	reverse_list([A1,A2,A3,A4],L1),
	reverse_list([B1,B2,B3,B4],L2),
	reverse_list([C1,C2,C3,C4],L3),
	reverse_list([D1,D2,D3,D4],L4),
	append(L1,L2,X),
	append(X,L3,Y),
	append(Y,L4,Z),
	diabolic(Z).

%----------Rotation about the center point---
%Change the values around the center, not change the center or the corners.
rotation_center([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],Z):-
	diabolic([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]),
	ins(B1,[A1,A4],2,T),
	ins(B4,T,3,U),
	ins(A2,U,5,V),
	ins(C2,[D2,C3],2,T2),
	ins(D3,T2,4,U2),
	ins(D1,U2,5,V2),
	append(V,[B2,B3],W),
	append(W,[A3],Y),
	append(V2,[C1,C4],W2),
	append(W2,[D4],X),
	append(Y,X,Z),
	diabolic(Z).
	
%----------Rotation of columns---------------
%Take the rightmost column and put it one to the left.
rotation_columns([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],Z):-
	diabolic([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]),
	rotatelist([A1,A2,A3,A4],L1),
	rotatelist([B1,B2,B3,B4],L2),
	rotatelist([C1,C2,C3,C4],L3),
	rotatelist([D1,D2,D3,D4],L4),
	append(L1,L2,X),
	append(X,L3,Y),
	append(Y,L4,Z),
	diabolic(Z).

%----------Rotation of rows------------------
%Remove the top row and tack it on the bottom.
rotation_rows([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],Z):-
	diabolic([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]),
	rotatelist([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],W),
	rotatelist(W,X),
 	rotatelist(X,Y),
 	rotatelist(Y,Z),
 	diabolic(Z).
 	
%----------Convolution-----------------------
%Take the rows and converts it in a 2x2 square.
convolution([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],Z):-
	diabolic([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]),
	append([A1,A4,B4,B1],[A2,A3,B3,B2],Y),
	append([D2,D3,C3,C2],[D1,D4,C4,C1],X),
	append(Y,X,Z),
	diabolic(Z).
