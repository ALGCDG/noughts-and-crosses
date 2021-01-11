#!/Applications/SWI-Prolog.app/Contents/MacOS/swipl -q -g main -s
:- consult(ox).
:- use_module(library(pce)).


main :-
    %new(F,frame('OX against the Machine')),
    new(F,picture('OX against the Machine')),
    send(F, size, size(300, 300)),
    send(F, display, new(B1, box(100,100))),
    send(F, display, new(B2, box(100,100)), point(0,100)),
    send(F, display, new(B3, box(100,100)), point(0,200)),
    send(F, display, new(B4, box(100,100)), point(100,0)),
    send(F, display, new(B5, box(100,100)), point(100,100)),
    send(F, display, new(B6, box(100,100)), point(100,200)),
    send(F, display, new(B7, box(100,100)), point(200,0)),
    send(F, display, new(B8, box(100,100)), point(200,100)),
    send(F, display, new(B9, box(100,100)), point(200,200)),
    send(F, display, new(E, circle(100)), point(200,200)),
    send(F,open),
    sleep(5),
    free(E),
    sleep(5),
    start_state(S),
    play(S),
    free(F),
    free(B1),
    free(B2),
    free(B3),
    free(B4),
    free(B5),
    free(B6),
    free(B7),
    free(B8),
    free(B9),
    halt.
