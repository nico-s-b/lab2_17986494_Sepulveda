%TDA Option
%Representación: Lista
%Code (int)
%Message(string)
%ChatbotCode (int)
%FlowCode (int)
%Keywords (list of strings)

%Reglas

%Predicado constructor de una opcion
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
    stringlist(Keys,MinusKeys),
    Option = [Code, Mens, Cblink, Flink, MinusKeys].

%Predicado de pertenencia para verificar duplicados
% oplistVerifier(Optionlist,Optionlist)
%Dominio: Optionlist (list of options) X Optionlist (list of options)
% Meta primaria: oplistVerifier/2
% Metas secundarias: optionGetElements/5 , opIsNotDuplicated/2 , oplistVerifier/2
oplistVerifier([],[]).
oplistVerifier([Option|Resto],[Option|OpAcum]):-
    optionGetElements(Option,Code,_,_,_,_),
    opIsNotDuplicated(Code,Resto),
    oplistVerifier(Resto,OpAcum).
% El siguiente predicado maneja errores y permitiría que, si hay
% opciones duplicadas en base al ID, filtrara para solo incluir una ocurrencia
%oplistVerifier([Op|Resto],OpAcum):-
%    optionGetElements(Op,Code,_,_,_,_),
%    \+ opIsNotDuplicated(Code,Resto),
%    oplistVerifier(Resto,OpAcum).

%Predicado auxiliar que realiza la verificación de duplicados
% opIsNotDuplicated(Option,Optionlist)
%Dominio: Option (TDA option) X Optionlist (list)
% Meta primaria: opIsNotDuplicated/2
% Metas secundarias: optionGetElements/5 , \=/2 , opIsNotDuplicated/2
opIsNotDuplicated(_,[]).
opIsNotDuplicated(Code,[Op|Oplist]):-
    optionGetElements(Op,Code2,_,_,_,_),
    Code \= Code2,
    opIsNotDuplicated(Code,Oplist).

% Predicado que encuentra un mensaje dentro de una opción,
% aprovechando explícitamente el backtraking para encontrar una opción
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

%Predicado Selector general para todos los elementos de Option
% optionGetElements(Option,Code,Message,ChatbotCodeLink,InitialFlowLink,Keywords)
%Dominio: Option (TDA option) X Code (int) X Message (string) X
%ChatbotCodeLink (int) InitialFlowLink (string) X Keywords (list)
% Meta primaria: optionGetElements/6
optionGetElements([E1, E2, E3, E4, E5], E1, E2, E3, E4, E5).

% Predicado que verifica que las keywords sean strings y las deja en
% minúsculas
%stringlist(List)
%Dominio: List (list)
% Meta primaria: stringlist/1
% Metas secundarias: string/1 , string_lower/2 , stringlist/1
stringlist([],[]).
stringlist([Str|Resto],[LowerStr|RestoLower]):-
    string(Str),
    string_lower(Str,LowerStr),
    stringlist(Resto,RestoLower).
