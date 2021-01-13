#!/Applications/SWI-Prolog.app/Contents/MacOS/swipl -q -g main -s
:-consult(game).

on_stailmate :-
    write("stailmate!\n").


on_machine_win :-
    write("the machine wins!\n").


on_human_win :-
    write("the human wins!\n").

display_state(State) :-
    write(State),
    write('\n').

main :-
    start_state(S),
    play(S, display_state, on_human_win, on_machine_win, on_stailmate),
    halt.
