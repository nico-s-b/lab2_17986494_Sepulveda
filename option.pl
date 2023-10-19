%Dominios
%Code = integer
%Message = string
%ChatbotCodeLink = integer
%InitialFlowLink = integer
%Keywords = list

%Predicados:
% option/4(Code, Message, ChatbotCodeLink, InitialFlowLink,Keywords)
% stringlist/1(Keywords)

%Metas
%Primarias
%option(Code,Mens,Cblink,Flink,Keys)
%Secundarias
%stringlist(L)

%Clausulas de Horn
%Base de conocimiento


%Reglas
option(Code, Mens, Cblink, Flink, Keys):-
    integer(Code), Code >= 0,
    string(Mens),
    integer(Cblink), Cblink >= 0,
    integer(Flink), Flink >= 0,
    stringlist(Keys).

stringlist([]):-!.
stringlist([A|B]):-
    string(A),
    stringlist(B).



