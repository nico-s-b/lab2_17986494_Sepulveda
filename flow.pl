:-module(flow, [flow/4,
               flowAddOption/3]).
:-use_module(option).

%Dominios
%Id = integer
%Message = string
%Oplist = list
%Code = integer
%Flow = list (TDA flow)
%Code = int (TDA option)
%Option = list (TDA option)

%Predicados:
% flow(Id, Name-msg, Oplist, Flow)
% flowAddOption(Flow, Option, Flow)
% oplistVerifier(Oplist, Oplist)
% opIsNotDuplicated(Code,Oplist)
% flowGetElements(Flow, Id, Name-msg, Oplist)

%Metas
%Primarias
%flow/4
%flowAddOption/3

%Secundarias
%oplistVerifier/2
%opIsNotDuplicated/2
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

flowAddOption(FlowIni, Op, FlowFin):-
    flowGetElements(FlowIni, E1, E2, Ops),
    append(Ops,[Op], Oplist),
    oplistVerifier(Oplist, RevOplist),
    flow(E1, E2, RevOplist, FlowFin).

flowAddOption(FlowIni, _, FlowFin):-
    FlowFin = FlowIni.
