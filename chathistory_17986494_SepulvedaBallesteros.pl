:-module(chathistory_17986494_SepulvedaBallesteros, [chatVerifier/1]).

%Dominios
%ChatHistory = list

chatVerifier([]).
chatVerifier([[Cblink,Flink,Msg]|Resto]):-
    string(Msg),
    integer(Cblink),
    integer(Flink),
    chatVerifier(Resto).


