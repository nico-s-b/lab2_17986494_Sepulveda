:-module(chatbot, [chatbot/6,
               chatbotAddFlow/3]).
:-use_module(flow).

%Dominios
%ChatbotId = integer
%Name = string
%WelcomeMessage = string
%StartFlowId= integer
%Flows = list
%Chatbot = list (TDA chatbot)
%Id = integer (TDA flow)
%Flow = list (TDA flow)

%Predicados:
% chatbot(ChatbotId,Name,WelcomeMessage,StartFlowId,Flows,Chatbot)
% chatbotAddFlow(Chatbot,Flow,Chatbot)
% chatbotGetElements(ChatbotId,Name,WelcomeMessage,StartFlowId,Flows,Chatbot)
% flowsVerifier(Flows,Flows)
% flowIsNotDuplicated(Id,Flows)
% addFlow(Flows,Flow,Flows)

%Metas
%Primarias
%chatbot/6
%chatbotAddFlow/3
%
%Secundarias
%chatbotGetElements/6
%flowsVerifier/2
%flowIsNotDuplicated/2
%addFlow/3

%Clausulas de Horn
%Base de conocimiento


%Reglas
chatbot(CbotID, Name, WelcMens, StartFlowID, Flows, Chatbot):-
    integer(CbotID),
    string(Name),
    string(WelcMens),
    integer(StartFlowID),
    flowsVerifier(Flows,RevFlows),
    Chatbot = [CbotID, Name, WelcMens, StartFlowID, RevFlows].

chatbotGetElements(Chatbot, E1, E2, E3, E4, E5):-
    nth0(0, Chatbot, E1),
    nth0(1, Chatbot, E2),
    nth0(2, Chatbot, E3),
    nth0(3, Chatbot, E4),
    nth0(4, Chatbot, E5).

flowVerifier([],[]).
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

chatbotAddFlow(CbotIni,Flow,CbotFin):-
    chatbotGetElements(CbotIni, E1, E2, E3, E4, Flows),
    addFlow(Flow,Flows,ResFlows),
    flowsVerifier(ResFlows,FlowsFin),
    chatbot(E1,E2,E3,E4,FlowsFin,CbotFin).

addFlow(Flow,[],[Flow]).
addFlow(Flow,[H|T],[H|ResFlows]):-
    addFlow(Flow,T,ResFlows).
