:-module(flow, [flow/4,
               flowAddOption/3,
               flowsVerifier/2]).
:-use_module(option_17986494_SepulvedaBallesteros).

%Dominios
%Id = integer
%Message = string
%Code = integer
%Flow = list (TDA flow)
%Option = list (TDA option)

%Predicados:
% flow(Id, Name-msg, Oplist, Flow)
% flowAddOption(Flow, Option, Flow)
% flowGetElements(Flow, Id, Name-msg, Oplist)
% flowVerifier(Flowlist,Flowlist)
% flowIsNotDuplicated(Id,Flowlist)

%Metas
%Primarias
%flow/4
%flowAddOption/3

%Secundarias
%flowsVerifier/2
%flowIsNotDuplicated/2
%flowGetElements/4

%Clausulas de Horn
%Base de conocimiento

%Reglas
flow(Id, Name, Oplist, Flow):-
    integer(Id), Id >= 0,
    string(Name),
    oplistVerifier(Oplist,RevOplist),
    Flow = [Id, Name, RevOplist].

flowGetElements(Flow, E1, E2, E3):-
    nth0(0, Flow, E1),
    nth0(1, Flow, E2),
    nth0(2, Flow, E3).

flowAddOption(FlowIni, Op, FlowFin):-
    flowGetElements(FlowIni, E1, E2, Ops),
    append(Ops,[Op], Oplist),
    oplistVerifier(Oplist, RevOplist),
    flow(E1, E2, RevOplist, FlowFin).
flowAddOption(FlowIni, _, FlowIni).

flowsVerifier([],[]).
flowsVerifier([F|Res],[Flow|Rest]):-
    flowGetElements(F, Id, E2, E3),
    flow(Id,E2,E3,Flow),
    flowIsNotDuplicated(Id,Res),
    flowsVerifier(Res,Rest).

flowIsNotDuplicated(_,[]).
flowIsNotDuplicated(Id,[Flow|Flowlist]):-
    flowGetElements(Flow,E1,_,_),
    Id \= E1,
    flowIsNotDuplicated(Id,Flowlist).
