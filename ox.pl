valid_position((X,Y)) :-
    between(1,3,X),
    between(1,3,Y).

change(max, (Max_visited, Min_visited), (Max_new, Min_visited)) :-
    valid_position(New),
    \+ member(New, Max_visited),
    \+ member(New, Min_visited),
    append([New], Max_visited, Max_new).

change(min, (Max_visited, Min_visited), (Max_visited, Min_new)) :-
    valid_position(New),
    \+ member(New, Max_visited),
    \+ member(New, Min_visited),
    append([New], Min_visited, Min_new).

start_state(([],[])).

adjacent(ul,(Xa,Ya), (Xb,Yb)) :-
    succ(Xb, Xa),
    succ(Ya, Yb).
adjacent(u,(Xa,Ya), (Xa,Yb)) :-
    succ(Ya, Yb).
adjacent(ur,(Xa,Ya), (Xb,Yb)) :-
    succ(Xa, Xb),
    succ(Ya, Yb).
adjacent(r,(Xa,Ya), (Xb,Ya)) :-
    succ(Xa, Xb).
adjacent(dr,(Xa,Ya), (Xb,Yb)) :-
    succ(Yb, Ya),
    succ(Xa, Xb).
adjacent(d,(Xa,Ya), (Xa,Yb)) :-
    succ(Yb, Ya).
adjacent(dl,(Xa,Ya), (Xb,Yb)) :-
    succ(Yb, Ya),
    succ(Xb, Xa).
adjacent(l,(Xa,Ya), (Xb,Ya)) :-
    succ(Xb, Xa).

goal_state((Max_visited, Min_visited)) :-
    member(A, Max_visited),
    member(B, Max_visited),
    adjacent(D, A, B),
    member(C, Max_visited),
    adjacent(D, B, C).

fail_state((Max_visited, Min_visited)) :-
    member(A, Min_visited),
    member(B, Min_visited),
    adjacent(D, A, B),
    member(C, Min_visited),
    adjacent(D, B, C).

stail_state((Max_visited, Min_visited)) :-
    length(Max_visited, MaxLen),
    length(Min_visited, MinLen),
    T is MaxLen + MinLen,
    T >= 9.

alternate(max, min).
alternate(min, max).

aggregate(max, Values, Value) :- max_list(Values, Value). 
aggregate(min, Values, Value) :- min_list(Values, Value). 

minmax(Turn, State, 1) :-
    goal_state(State), !.

minmax(Turn, State, -1) :-
    fail_state(State), !.

minmax(Turn, State, 0) :-
    stail_state(State), !.

minmax(Turn, State, Value) :-
    findall(X, change(Turn, State, X), Children),
    alternate(Turn,NextTurn),
    maplist(minmax(NextTurn), Children, Values),
    aggregate(Turn, Values, Value).
