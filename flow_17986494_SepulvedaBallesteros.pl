:-module(flow_17986494_SepulvedaBallesteros, [flow/4,
               flowAddOption/3,
               flowsVerifier/2,
               getFlowFromList/3,
               flowGetElements/4]).
:-use_module(option_17986494_SepulvedaBallesteros).

%Clausulas de Horn
%Base de conocimiento

%Reglas

%Predicado
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

%Predicado:
% flowGetElements(Flow, Id, Name, Oplist)
%Dominio:
%Flow (TDA flow) X Id (int) X Name (string) X Oplist (list of options)
% Meta primaria: flowGetElements/4
flowGetElements([E1, E2, E3, _], E1, E2, E3).

%Predicado
% flowAddOption(Flow, Option, Flow)
%Dominio: Flow (TDA flow) X Option (TDA option) X Flow (TDA flow)
% Meta primaria: flowAddOption/3
% Metas secundarias: flowGetElements/4 , append/3, oplistVerifier/2 , flow/4
flowAddOption(FlowIni, Op, FlowFin):-
    flowGetElements(FlowIni, E1, E2, Ops),
    append(Ops,[Op], Oplist),
    oplistVerifier(Oplist, RevOplist),
    flow(E1, E2, RevOplist, FlowFin).
flowAddOption(FlowIni, _, FlowIni).

%Predicado
% flowVerifier(Flowlist,Flowlist)
%Dominio: Flowlist (list of flows) X Flowlist (list of flows)
% Meta primaria: flowsVerifier/2
% Metas secundarias: flowGetElements/4 , flow/4 ,
% flowIsNotDuplicated/2 , flowsVerifier/2
flowsVerifier([],[]).
flowsVerifier([F|Res],[Flow|Rest]):-
    flowGetElements(F, Id, E2, E3),
    flow(Id,E2,E3,Flow),
    flowIsNotDuplicated(Id,Res),
    flowsVerifier(Res,Rest).

%Predicado
% flowIsNotDuplicated(Id,Flowlist)
%Dominio: Id (int) X Flowlist (list of flows)
% Meta primaria: flowIsNotDuplicated/2
% Metas secundarias: flowGetElements/4 , \=/2 , flowIsNotDuplicated/2
flowIsNotDuplicated(_,[]).
flowIsNotDuplicated(Id,[Flow|Flowlist]):-
    flowGetElements(Flow,E1,_,_),
    Id \= E1,
    flowIsNotDuplicated(Id,Flowlist).

%Predicado
% getFlowFromList(FlowId, Flows, Flow)
% Dominio:
% Id (int) , Flows (list of flows) , Flow (TDA flow)
% Meta primaria: getFlowFromList/3
% Metas secundarias: flowGetElements/4, !/0
getFlowFromList(Id, [Flow|_], Flow):-
    flowGetElements(Flow,Id,_,_),!.
% Metas secundarias: getChatbotFromList/3
getFlowFromList(Id,[_|Flows],Flow):-
    getFlowFromList(Id,Flows,Flow).
