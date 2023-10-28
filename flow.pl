:-module(flow, [flow/4]).
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

%Secundarias
%oplistVerifier/2
%opIsNotDuplicated/2

%Clausulas de Horn
%Base de conocimiento


%Reglas
flow(Id, Name, Oplist, Flow):-
    integer(Id), Id >= 0,
    string(Name),
    oplistVerifier(Oplist,RevOplist),
    Flow = [Id, Name, RevOplist].

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


