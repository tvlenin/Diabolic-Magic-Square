%---------------------Validations---------------------
diabolic([1,8,13,12,14,11,2,7,4,5,16,9,15,10,3,6]).
diabolic([1,12,7,14,8,13,2,11,10,3,16,5,15,6,9,4]).
diabolic([1,8,11,14,12,13,2,7,6,3,16,9,15,10,5,4]).
diabolic([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]):- %Checking any 4x4 Square.
/* [	A1,A2,A3,A4,
		B1,B2,B3,B4,
		C1,C2,C3,C4,
		D1,D2,D3,D4		]*/

%37 Validations!  
%_______Rows(4)_______
A1+A2+A3+A4=:=34,
B1+B2+B3+B4=:=34,
C1+C2+C3+C4=:=34,
D1+D2+D3+D4=:=34,
%______Columns(4)_____
A1+B1+C1+D1=:=34,
A2+B2+C2+D2=:=34,
A3+B3+C3+D3=:=34,
A4+B4+C4+D4=:=34,
%___Diagonals \ (8)___
A1+B2+C3+D4=:=34,
B1+C2+D3+A4=:=34,
C1+D2+A3+B4=:=34,
D1+A2+B3+C4=:=34,
%___Diagonals / (8)___
A4+B3+C2+D1=:=34,
B4+C3+D2+A1=:=34,
C4+D3+A2+B1=:=34,
D4+A3+B2+C1=:=34,
%_______2x2(16)_______
A1+A2+B1+B2=:=34,
A2+A3+B2+B3=:=34,
A3+A4+B3+B4=:=34,
A4+A1+B4+B1=:=34,
B1+B2+C1+C2=:=34,
B2+B3+C2+C3=:=34,
B3+B4+C3+C4=:=34,
B4+B1+C4+C1=:=34,
C1+C2+D1+D2=:=34,
C2+C3+D2+D3=:=34,
C3+C4+D3+D4=:=34,
C4+C1+D4+D1=:=34,
D1+D2+A1+A2=:=34,
D2+D3+A2+A3=:=34,
D3+D4+A3+A4=:=34,
D4+D1+A4+A1=:=34,
%_____3x3(corners)____
A1+A3+C1+C3=:=34,
A2+A4+C2+C4=:=34,
B1+B3+D1+D3=:=34,
B2+B4+D2+D4=:=34,
%_____4x4(corners)____
A1+A4+D1+D4=:=34.



%A4+B3+C2+D1=:=34, A1+B2+C3+D4=:=34,%Cheking diagonals.
%A1+A2+A3+A4=:=34, B1+B2+B3+B4=:=34, C1+C2+C3+C4=:=34, D1+D2+D3+D4=:=34,%Checking rows. 
%A1+B1+C1+D1=:=34, A2+B2+C2+D2=:=34, A3+B3+C3+D3=:=34, A4+B4+C4+D4=:=34,%Checking columns.
%A1+A3+C1+C3=:=34, A2+A4+C2+C4=:=34, B1+B3+D1+D3=:=34, B2+B4+D2+D4=:=34,%Checking 3x3 square corners.
%A1+A2+B1+B2=:=34, A3+A4+B3+B4=:=34, C1+C2+D1+D2=:=34, C3+C4+D3+D4=:=34, A2+A3+B2+B3=:=34, C2+C3+D2+D3=:=34, %Checking 2x2 squares.
%A1+B1+C3+D3=:=34, A2+B2+C4+D4=:=34, A3+B3+C1+D1=:=34, A4+B4+C2+D2=:=34, A1+A2+C3+C4=:=34, A3+A4+C1+C2=:=34, B1+B2+D3+D4=:=34, B3+B4+D1+D2=:=34. %Checking desplaced pairs.


diabolic(A,B):- diabolic(A), reflection(A,B).
diabolic(A,B,C):- diabolic(A,B),rotationCenter(A,C).
diabolic(A,B,C,D):-diabolic(A,B,C),rotationColumns(A,D).
diabolic(A,B,C,D,E):-diabolic(A,B,C,D),rotationRows(A,E).
diabolic(A,B,C,D,E,F):-diabolic(A,B,C,D,E),convolution(A,F).
diabolic(A,B,C,D,E,F,G):-diabolic(A,B,C,D,E,F),reflection(C,G).
diabolic(A,B,C,D,E,F,G,H):-diabolic(A,B,C,D,E,F,G),rotationCenter(D,H).
diabolic(A,B,C,D,E,F,G,H,I):-diabolic(A,B,C,D,E,F,G,H),rotationColumns(B,I).
diabolic(A,B,C,D,E,F,G,H,I,J):-diabolic(A,B,C,D,E,F,G,H,I),rotationRows(B,J).


%---------------------Showall---------------------
showall:-showall( [1,8,13,12,14,11,2,7,4,5,16,9,15,10,3,6], [1,12,7,14,8,13,2,11,10,3,16,5,15,6,9,4], [1,8,11,14,12,13,2,7,6,3,16,9,15,10,5,4]).
showall(A,B,C):-
	showall(A),
	showall(B),
	showall(C).
showall(A):-
	reflection(A,ReflectionOfA),
	showallaux(A),
	showallaux(ReflectionOfA).

%Have the first magic squares and call all other auxiliars.
showallaux(A):-
	rotationCenter(A,RotationOfA),
	convolution(A,ConvolutionOfA),
	rotationCenter(ConvolutionOfA,RotationCenterOfA),
	convolution(RotationOfA,RotationOfAConv),
	print([RotationOfA,ConvolutionOfA,RotationCenterOfA,RotationOfAConv]),
	auxRotate3Rows(A),
	auxRotate3Rows(RotationOfA),
	auxRotate3Rows(ConvolutionOfA),
	auxRotate3Rows(RotationCenterOfA),
	auxRotate3Rows(RotationOfAConv).

%rotate a row and a column three times 
auxRotate3Rows(A):-
	rotationRows(A,A1),
	auxRotate3Columns(A1),
	rotationRows(A1,A2),
	auxRotate3Columns(A2),
	rotationRows(A2,A3),
	auxRotate3Columns(A3),
	print([A1,A2,A3]).
auxRotate3Columns(A):-
	rotationColumns(A,A1),
	rotationColumns(A1,A2),
	rotationColumns(A2,A3),
	print([A1,A2,A3]).	
	 
 
%-------------------------Transformations--------------
reflection([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],ANS):-
	diabolic([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]),
	reverse([A1,A2,A3,A4],LA),
	reverse([B1,B2,B3,B4],LB),
	reverse([C1,C2,C3,C4],LC),
	reverse([D1,D2,D3,D4],LD),
	append(LA,LB,X),
	append(X,LC,Y),
	append(Y,LD,ANS),
	diabolic(ANS).

rotationCenter([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],ANS):-
	diabolic([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]),
	add(B1,[A1,A4],2,T),
	add(B4,T,3,U),
	add(A2,U,5,V),
	add(C2,[D2,C3],2,T2),
	add(D3,T2,4,U2),
	add(D1,U2,5,V2),
	append(V,[B2,B3],W),
	append(W,[A3],Y),
	append(V2,[C1,C4],W2),
	append(W2,[D4],X),
	append(Y,X,ANS),
	diabolic(ANS).
	
rotationColumns([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],ANS):-
	diabolic([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]),
	rotatelist([A1,A2,A3,A4],L1),
	rotatelist([B1,B2,B3,B4],L2),
	rotatelist([C1,C2,C3,C4],L3),
	rotatelist([D1,D2,D3,D4],L4),
	append(L1,L2,X),
	append(X,L3,Y),
	append(Y,L4,ANS),
	diabolic(ANS).

rotationRows([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],ANS):-
	diabolic([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]),
	rotatelist([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],W),
	rotatelist(W,X),
 	rotatelist(X,Y),
 	rotatelist(Y,ANS),
 	diabolic(ANS).
 	
convolution([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],ANS):-
	diabolic([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]),
	append([A1,A4,B4,B1],[A2,A3,B3,B2],Y),
	append([D2,D3,C3,C2],[D1,D4,C4,C1],X),
	append(Y,X,ANS),
	diabolic(ANS).
	
	
%-----------------------AUXILIARY ------------------
reverse(list,list).
reverse(InList,Outlist):- reverseAux(InList,[],Outlist). 
reverseAux(list,list,list).
reverseAux([],Outlist,Outlist).    
reverseAux([Head|Tail],L1,L2):-reverseAux(Tail,[Head|L1],L2).

rotatelist([H|T], R) :- append(T, [H], R).
%Insert an element in the nth place
add(Val,[H|List],Pos,[H|Res]):- Pos > 1,!,Pos1 is Pos - 1, 
add(Val,List,Pos1,Res). 
add(Val, List, 1, [Val|List]).


%this function prints a list 
%print([]).
%print([X|Xs]):-
%	write(X),
%	nl,
%	print(Xs).

print([]).
print( [ [A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4] |Xs]):-
	write('------------'),
	nl,
	write('['),
	write([A1,A2,A3,A4]),
	nl,
	write([B1,B2,B3,B4]),
	nl,
	write([C1,C2,C3,C4]),
	nl,
	write([D1,D2,D3,D4]),
	write(']'),
	nl,
	print(Xs).