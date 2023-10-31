:-module(flow, [flow/4,
               flowAddOption/3]).
:-use_module(option).

%Dominios
%Id = integer
%Message = string
%Oplist = list
%RevOplist = list
%Code = integer
%Flow = list (TDA flow)

%Predicados:
% flow(Id, Name-msg, Oplist, Flow)
% oplistVerifier(Oplist, RevOplist)
% opIsNotDuplicated(Code,Oplist)

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
    optionGetElements(Op,R1,R2,R3,R4,R5),
    option(R1,R2,R3,R4,R5,Opt),
    opIsNotDuplicated(R1,Res),
    oplistVerifier(Res,Rest).

opIsNotDuplicated(_,[]).
opIsNotDuplicated(R1,[HOp|Oplist]):-
    optionGetElements(HOp,R_1,_,_,_,_),
    R1 \= R_1,
    opIsNotDuplicated(R1,Oplist).

flowAddOption(FlowIni, Op, FlowFin):-
    flowGetElements(FlowIni, E1, E2, E3),
    Oplist = [Op|E3],
    oplistVerifier(Oplist, RevOplist),
    flow(E1, E2, RevOplist, FlowFin).

flowAddOption(FlowIni, _, FlowFin):-
    FlowFin = FlowIni.
