:-consult(ox).

play(State, DisplayState, OnHumanWin, OnBotWin, OnStailmate) :-
    goal_state(State),
    call(OnBotWin).
play(State, DisplayState, OnHumanWin, OnBotWin, OnStailmate) :-
    fail_state(State),
    call(OnHumanWin).
play(State, DisplayState, OnHumanWin, OnBotWin, OnStailmate) :-
    stail_state(State),
    call(OnStailmate).
play(State, DisplayState, OnHumanWin, OnBotWin, OnStailmate) :-
    call(DisplayState, State),
    bot(State,A),
    call(DisplayState, A),
    human(A, B),
    call(DisplayState, B),
    play(B).
