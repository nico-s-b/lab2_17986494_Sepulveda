:-module(flow, [flow/4]).
:-use_module(option).

%Dominios
%Id = integer
%Message = string
%Oplist = list
%Flow = list (TDA flow)

%Predicados:
% flow/4(Id, Name-msg, Oplist, Flow)
% stringlist/1(Keywords)

%Metas
%Primarias
%flow/4

%Secundarias
%verificarOp/2

%Clausulas de Horn
%Base de conocimiento


%Reglas
flow(Id, Name, Oplist, Flow):-
    integer(Id), Id >= 0,
    string(Name),
    oplistVerifier(Oplist,RevOplist),
    Flow = [Id, Name, Oplist].

oplistVerifier([],[]).
oplistVerifier([Op|Res],[Opt|Rest]):-
    optionGetElements(Op,R1,R2,R3,R4,R5),
    option(R1,R2,R3,R4,R5,Opt),
    opIsNotDuplicated(R1,Res),
    oplistVerifier(Res,Rest).
oplistVerifier([Op|Res],Rest).

opIsNotDuplicated(_,[]).
opIsNotDuplicated(R1,[HOp|Oplist]):-
    optionGetElements(HOp,R_1,_,_,_,_),
    R1 \= R_1,
    opIsNotDuplicated(R1,Oplist).
