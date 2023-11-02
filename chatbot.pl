:-module(chatbot, [chatbot/6,
                  chatbotAddFlow/3,
                  chatbotsVerifier/2]).
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

chatbotAddFlow(CbotIni,Flow,CbotFin):-
    chatbotGetElements(CbotIni, E1, E2, E3, E4, Flows),
    addFlow(Flow,Flows,ResFlows),
    flowsVerifier(ResFlows,FlowsFin),
    chatbot(E1,E2,E3,E4,FlowsFin,CbotFin).

addFlow(Flow,[],[Flow]).
addFlow(Flow,[H|T],[H|ResFlows]):-
    addFlow(Flow,T,ResFlows).

chatbotsVerifier([],[]).
chatbotsVerifier([Cbot|Res],[Cbot2|Rest]):-
    chatbotGetElements(Cbot,Id,E2,E3,E4,E5),
    chatbot(Id,E2,E3,E4,E5,Cbot2),
    chatbotIsNotDuplicated(Id,Res),
    chatbotsVerifier(Res,Rest).

chatbotIsNotDuplicated(_,[]).
chatbotIsNotDuplicated(Id,[Cbot|Res]):-
    chatbotGetElements(Cbot,Id2,_,_,_,_),
    Id \= Id2,
    chatbotIsNotDuplicated(Id,Res).
