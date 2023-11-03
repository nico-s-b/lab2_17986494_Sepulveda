:-module(chathistory, [chathistory/2]).

%Dominio

chathistory(Chat,Chat):-
    stringlist(Chat).


stringlist([]):-!.
stringlist([A|B]):-
    string(A),
    stringlist(B).
