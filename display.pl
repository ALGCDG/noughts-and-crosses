#!/Applications/SWI-Prolog.app/Contents/MacOS/swipl -q -g main -s
:- consult(game).
:- use_module(library(pce)).

on_stailmate :-
    write("stailmate!\n").


on_machine_win :-
    write("the machine wins!\n").


on_human_win :-
    write("the human wins!\n").

drawO([]).
drawO([(X,Y)|T]) :-
    write('drawing Os'),
    Px is (X-1)*100,
    Py is (Y-1)*100,
    send(F, display, new(E, circle(100)), point(Px,Py)),
    drawO(T).
drawX([]).
drawX([(X,Y)|T]) :-
    write('drawing Xs'),
    Px is (X-1)*100,
    Py is (Y-1)*100,
    send(F, display, new(E, circle(100)), point(Px,Py)),
    drawX(T).


display_state((Max_visited, Min_visited)) :-
    write('drawing state'),
    drawO(Max_visited),
    drawX(Min_visited).



main :-
    write("hi"),
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
    send(F,open),
    write('hello world'),
    start_state(S),
    write('hello'),
    play(S, display_state, on_human_win, on_machine_win, on_stailmate),
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
