:-module(option_17986494_SepulvedaBallesteros, [option/6,
                 oplistVerifier/2]).

%Dominios
%Code = integer
%Message = string
%ChatbotCodeLink = integer
%InitialFlowLink = integer
%Keywords = list
%Option = list (TDA option)
%Oplist = list

%Predicados:
% option(Code,Message,ChatbotCodeLink,InitialFlowLink,Keywords,Option)
% optionGetElements(Option,Code,Message,ChatbotCodeLink,InitialFlowLink,Kewwords)
% oplistVerifier(Oplist, Oplist)
% opIsNotDuplicated(Code,Oplist)
% stringlist(Keywords)

%Metas
%Primarias
%option/6
%
%Secundarias
%optionGetElements/6
%oplistVerifier/2
%optionIsNotDuplicated/2
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
    nth0(0, Option, E1),
    nth0(1, Option, E2),
    nth0(2, Option, E3),
    nth0(3, Option, E4),
    nth0(4, Option, E5).

stringlist([]):-!.
stringlist([A|B]):-
    string(A),
    stringlist(B).

oplistVerifier([],[]).
oplistVerifier([Op|Res],[Opt|Rest]):-
    optionGetElements(Op,Code,R2,R3,R4,R5),
    option(Code,R2,R3,R4,R5,Opt),
    opIsNotDuplicated(Code,Res),
    oplistVerifier(Res,Rest).

opIsNotDuplicated(_,[]).
opIsNotDuplicated(Code,[HOp|Oplist]):-
    optionGetElements(HOp,Code2,_,_,_,_),
    Code\= Code2,
    opIsNotDuplicated(Code,Oplist).

