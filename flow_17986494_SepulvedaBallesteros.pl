%TDA Flow
%Representaci�n: Lista
%Id (int)
%Message(string)
%Options (list of Options)

%Reglas

%Predicado constructor de un nuevo chatbot
% flow(Id, Name-msg, Oplist, Flow)
%Dominio:
% Id (int) X Name (string) X Oplist (list of options) X Flow (TDA flow)
% Meta primaria: flow/4
% Metas secundarias: integer/1, >=/2 , string/1 , oplistVerifier/2
flow(Id, Name, Oplist, Flow):-
    integer(Id), Id >= 0,
    string(Name),
    oplistVerifier(Oplist,RevOplist),
    Flow = [Id, Name, RevOplist].

%Predicado modificador para a�adir opciones
% flowAddOption(Flow, Option, Flow)
%Dominio: Flow (TDA flow) X Option (TDA option) X Flow (TDA flow)
% Meta primaria: flowAddOption/3
% Metas secundarias: flowGetElements/4 , append/3, oplistVerifier/2 , flow/4
flowAddOption(FlowIni, Option, FlowFin):-
    flowGetElements(FlowIni, E1, E2, OplistIni),
    append(OplistIni,[Option], Oplist),
    oplistVerifier(Oplist,RevOplist),
    flow(E1, E2, RevOplist, FlowFin).
% Esta clausula comentada permite manejar el caso de opciones duplicadas
% devolviendo el flujo sin cambios en caso de agregar un duplicado.
%flowAddOption(Flow, Option, Flow):-
%    flowGetElements(Flow, _, _, Oplist),
%    append(Oplist,[Option], Oplist2),
%    \+ oplistVerifier(Oplist2,_).

%Predicado de verificaci�n de duplicados
% flowVerifier(Flowlist)
%Dominio: Flowlist (list of flows) X Flowlist (list of flows)
% Meta primaria: flowsVerifier/2
% Metas secundarias: flowGetElements/4 , flow/4 ,
% flowIsNotDuplicated/2 , flowsVerifier/2
flowsVerifier([],[]).
flowsVerifier([Flow|Resto],[Flow|FlowAcum]):-
    flowGetElements(Flow, Id, _, _),
    flowIsNotDuplicated(Id,Resto),
    flowsVerifier(Resto,FlowAcum).
% El siguiente predicado permite manejar el caso de que la lista de
% flujos inicialmente fuera creada con opciones repetidas, filtrando las
% repeticiones asegurando la integridad del flujo
%flowsVerifier([F|Resto],FlowAcum):-
%    flowGetElements(F, Id, _, _),
%    \+ flowIsNotDuplicated(Id,Resto),
%    flowsVerifier(Resto,FlowAcum).


%Predicado auxiliar que identifica IDs repetidos en un listado de flows
% flowIsNotDuplicated(Id,Flowlist)
%Dominio: Id (int) X Flowlist (list of flows)
% Meta primaria: flowIsNotDuplicated/2
% Metas secundarias: flowGetElements/4 , \=/2 , flowIsNotDuplicated/2
flowIsNotDuplicated(_,[]).
flowIsNotDuplicated(Id,[Flow|Flowlist]):-
    flowGetElements(Flow,E1,_,_),
    Id \= E1,
    flowIsNotDuplicated(Id,Flowlist).

% Predicado selector espec�fico: Identifica un flow dentro de una lista
% a partir de su ID
% getFlowFromList(FlowId, Flows, Flow)
% Dominio: Id (int) , Flows (list of flows) , Flow (TDA flow)
% Meta primaria: getFlowFromList/3
% Metas secundarias: flowGetElements/4, !/0
getFlowFromList(Id, [Flow|_], Flow):-
    flowGetElements(Flow,Id,_,_),!.
% Metas secundarias: getChatbotFromList/3
getFlowFromList(Id,[_|Flows],Flow):-
    getFlowFromList(Id,Flows,Flow).

%Predicado selector general
% flowGetElements(Flow, Id, Name, Oplist)
%Dominio:
%Flow (TDA flow) X Id (int) X Name (string) X Oplist (list of options)
% Meta primaria: flowGetElements/4
flowGetElements([E1, E2, E3], E1, E2, E3).
