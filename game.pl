:-consult(ox).

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
