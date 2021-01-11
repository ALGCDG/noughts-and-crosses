#!/Applications/SWI-Prolog.app/Contents/MacOS/swipl -q -g main -s


:-consult(game).

main :-
    start_state(S),
    play(S),
    halt.
