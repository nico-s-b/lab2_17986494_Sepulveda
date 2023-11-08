:-module(option_17986494_SepulvedaBallesteros, [option/6,
                                               oplistVerifier/2,
                                               msgInOptionList/4]).



%Clausulas de Horn
%Base de conocimiento

%Reglas

%Predicado
% option(Code,Message,ChatbotCodeLink,InitialFlowLink,Keywords,Option)
%Dominio: Code (int) X Message (string) X ChatbotCodeLink (int)
%InitialFlowLink (string) X Keywords (list) X Option (TDA option)
% Meta primaria: option/6
% Metas secundarias: integer/1 , >=/2 , string/1 , string/1 , stringlist/1
option(Code, Mens, Cblink, Flink, Keys, Option):-
    integer(Code), Code >= 0,
    string(Mens),
    integer(Cblink), Cblink >= 0,
    integer(Flink), Flink >= 0,
    stringlist(Keys),
    Option = [Code, Mens, Cblink, Flink, Keys].

%Predicado
% optionGetElements(Option,Code,Message,ChatbotCodeLink,InitialFlowLink,Keywords)
%Dominio: Option (TDA option) X Code (int) X Message (string) X
%ChatbotCodeLink (int) InitialFlowLink (string) X Keywords (list)
% Meta primaria: optionGetElements/6
optionGetElements([E1, E2, E3, E4, E5], E1, E2, E3, E4, E5).

%Predicado
% stringlist(List)
%Dominio: List (list)
% Meta primaria: stringlist/1
% Metas secundarias: string/1 , stringlist/1
stringlist([]).
stringlist([A|B]):-
    string(A),
    stringlist(B).

%Predicado
% oplistVerifier(Optionlist,Optionlist)
%Dominio: Optionlist (list of options) X Optionlist (list of options)
% Meta primaria: oplistVerifier/2
% Metas secundarias: optionGetElements/5 , opIsNotDuplicated/2 , oplistVerifier/2
oplistVerifier([],[]).
oplistVerifier([Option|Resto],[Option|OpAcum]):-
    optionGetElements(Option,Code,_,_,_,_),
    opIsNotDuplicated(Code,Resto),
    oplistVerifier(Resto,OpAcum).
oplistVerifier([Op|Resto],OpAcum):-
    optionGetElements(Op,Code,_,_,_,_),
    \+ opIsNotDuplicated(Code,Resto),
    oplistVerifier(Resto,OpAcum).

%Predicado
% opIsNotDuplicated(Option,Optionlist)
%Dominio: Option (TDA option) X Optionlist (list)
% Meta primaria: opIsNotDuplicated/2
% Metas secundarias: optionGetElements/5 , \=/2 , opIsNotDuplicated/2
opIsNotDuplicated(_,[]).
opIsNotDuplicated(Code,[Op|Oplist]):-
    optionGetElements(Op,Code2,_,_,_,_),
    Code \= Code2,
    opIsNotDuplicated(Code,Oplist).

%Predicado
% msgInOption(Message,Option,ChatbotCodeLink,InitialFlowLink)
%Dominio: Message (int or string) X Option (TDA option) X
%ChatbotCodeLink (int) X InitialFlowLink (int)
% Meta primaria: msgInOption/4
% Metas secundarias: optionGetElements/6 , string_lower/2 , member/2 , number_string/2 , =/2
msgInOptionList(Msg,[Option|_],Cblink,Flink):-
    optionGetElements(Option,Code,_,Cblink,Flink,Keywords),
    string_lower(Msg,MsgLower),
    (member(MsgLower,Keywords) ; number_string(Code,CodeStr), MsgLower = CodeStr).
% Metas secundarias: msgInOptionList/4
msgInOptionList(Msg,[_|Oplist],Cblink,Flink):-
    msgInOptionList(Msg,Oplist,Cblink,Flink).
