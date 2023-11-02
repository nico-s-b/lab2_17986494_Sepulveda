




stringlist([]):-!.
stringlist([A|B]):-
    string(A),
    stringlist(B).
