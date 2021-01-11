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
    %aggregate(Turn, Values, Value).
    sum_list(Values, Value).

% a predicate for getting a human input
human((Max_visited, Min_visited),(Max_visited,Min_new)) :-
    write("input action"),
    read(Player_choice),
    valid_position(Player_choice),
    \+ member(Player_choice, Max_visited),
    \+ member(Player_choice, Min_visited),
    append([Player_choice],Min_visited,Min_new).

best([], Best, Best).
best([H|T], empty, Best) :-
    best([H|T], H, Best).
best([State| T], TmpBest, Best) :-
    minmax(max, State, ValueA),
    minmax(max, TmpBest, ValueB),
    ValueA < ValueB,
    best(T, TmpBest, Best).
best([State| T], TmpBest, Best) :-
    minmax(max, State, ValueA),
    minmax(max, TmpBest, ValueB),
    ValueA >= ValueB,
    best(T, State, Best).


% a predicate which takes a state and finds an action
bot(State, NState) :-
    findall(X, change(max, State, X), Possible_actions),
    best(Possible_actions, empty, NState). 
play(State) :-
    goal_state(State),
    write("the machine wins!").
play(State) :-
    fail_state(State),
    write("the human wins!").
play(State) :-
    stail_state(State),
    write("stailmate!").
play(State) :-
    write(State),
    write("\n"),
    bot(State,A),
    write(A),
    write("\n"),
    human(A, B),
    write(B),
    write("\n"),
    play(B).
