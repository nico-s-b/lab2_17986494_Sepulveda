:-module(option, [option/6,
                 optionGetElements/6]).

%Dominios
%Code = integer
%Message = string
%ChatbotCodeLink = integer
%InitialFlowLink = integer
%Keywords = list
%Option = list (TDA option)

%Predicados:
% option(Code,Message,ChatbotCodeLink,InitialFlowLink,Keywords,Option)
% optionGetElements(Option, E1, E2, E3, E4, E5):
% stringlist(Keywords)

%Metas
%Primarias
%option/6
%
%Secundarias
%optionGetElements/6
%stringlist/1

%Clausulas de Horn
%Base de conocimiento


%Reglas
option(Code, Mens, Cblink, Flink, Keys, Option):-
    integer(Code), Code >= 0,
    string(Mens),
    integer(Cblink), Cblink >= 0,
    integer(Flink), Flink >= 0,
    stringlist(Keys),
    Option = [Code, Mens, Cblink, Flink, Keys].

optionGetElements(Option, E1, E2, E3, E4, E5):-
    nth0(0, Option, R1),
    nth0(1, Option, R2),
    nth0(2, Option, R3),
    nth0(3, Option, R4),
    nth0(4, Option, R5).

stringlist([]):-!.
stringlist([A|B]):-
    string(A),
    stringlist(B).



