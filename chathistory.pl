:-module(chathistory, [chathistory/2]).

%Dominios
%ChatHistory = list

chathistory(ChatH,ChatH):-
    stringlist(ChatH).



stringlist([]):-!.
stringlist([A|B]):-
    string(A),
    stringlist(B).
