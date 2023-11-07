:-module(chathistory_17986494_SepulvedaBallesteros, [chathistory/1]).

%Dominios
%ChatHistory = list

chathistory([]).
chathistory([Chat|Resto]):-
    Chat = [Cblink,Flink,Msg],
    string(Msg),
    integer(Cblink),
    integer(Flink),
    chathistory(Resto).




stringlist([]):-!.
stringlist([A|B]):-
    string(A),
    stringlist(B).
