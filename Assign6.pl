% Robin R
% Homework 6 - Cracker Barrel Game
% ReadMe:-
% - Must install the lambda package in library folder to use library(lambda) and run program.
% Package located at http://www.swi-prolog.org/pack/list?p=lambda

% - Before running the program, edit the code using the comment blocks marked with "@" symbols
% to solve the puzzle for different starting positions.

% - To run the program within SWI-prolog, first consult it, and enter "?- iq_game.".
% To get a new iteration of the puzzle, simply press ";" after one iteration is shown.

:- use_module(library(lambda)).
 
cb_game :-
	cb_game(Moves),
	on_screen(Moves).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute soln
% change the peg number within parameter one in exe()
% and remove that peg number from the list in parameter two
% to solve for when that peg is empty
% example to solve for peg 4:
%     -> exe([4], [1,2,3,5,6,7,8,9,10,11,12,13,14,15], [], Moves).

cb_game(Moves) :-
	execute([1], [2,3,4,5,6,7,8,9,10,11,12,13,14,15], [], Moves).
 
execute(_, [_], Lst, Moves) :-
	reverse(Lst, Moves).
 
execute(Free, Occupied, Lst, Moves) :-
	select(S, Occupied, Oc1),
	select(O, Oc1, Oc2),
	select(E, Free, F1),
	move(S, O, E),
	execute([S, O | F1], [E | Oc2], [move(S,O,E) | Lst], Moves).
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% allowed moves
% (from peg, over peg, to location)

move(S,2,E) :-
	member([S,E], [[1,4], [4,1]]).
move(S,3,E) :-
	member([S,E], [[1,6], [6,1]]).
move(S,4,E):-
	member([S,E], [[2,7], [7,2]]).
move(S,5,E):-
	member([S,E], [[2,9], [9,2]]).
move(S,5,E):-
	member([S,E], [[3,8], [8,3]]).
move(S,6,E):-
	member([S,E], [[3,10], [10,3]]).
move(S,5,E):-
	member([S,E], [[4,6], [6,4]]).
move(S,7,E):-
	member([S,E], [[4,11], [11,4]]).
move(S,8,E):-
	member([S,E], [[4,13], [13,4]]).
move(S,8,E):-
	member([S,E], [[5,12], [12,5]]).
move(S,9,E):-
	member([S,E], [[5,14], [14,5]]).
move(S,9,E):-
	member([S,E], [[6,13], [13,6]]).
move(S,10,E):-
	member([S,E], [[6,15], [15,6]]).
move(S,8,E):-
	member([S,E], [[9,7], [7,9]]).
move(S,9,E):-
	member([S,E], [[10,8], [8,10]]).
move(S,12,E):-
	member([S,E], [[11,13], [13,11]]).
move(S,13,E):-
	member([S,E], [[12,14], [14,12]]).
move(S,14,E):-
	member([S,E], [[15,13], [13,15]]).
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% on_screen soln
% change the peg number within the second parameter in print()
% to solve for when that peg is empty 
% hint-> print(Solutions, [peg#]).

on_screen(Sol) :-
	on_screen(Sol, [1]).
 
% numlist and maplist are built in Prolog funtions
% format and writeln are forms of output for Prolog
% ...\X^I^... requires Prolog lambda library

on_screen([], Free) :-
	numlist(1,15, Lst),
	maplist(\X^I^(member(X, Free) -> I = 0; I = 1),
		Lst,
		[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n', [I11,I12,I13,I14,I15]),
	writeln(solved).
 
 
on_screen([move(Start, Middle, End) | Tail], Free) :-
	numlist(1,15, Lst),
	maplist(\X^I^(member(X, Free) -> I = 0; I = 1),
		Lst,
		[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n', [I11,I12,I13,I14,I15]),
	format('From ~w to ~w over ~w~n~n~n', [Start, End, Middle]),
	select(End, Free, F1),
	on_screen(Tail,  [Start, Middle | F1]).