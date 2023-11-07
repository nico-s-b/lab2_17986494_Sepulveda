:-module(chatbot_17986494_SepulvedaBallesteros, [chatbot/6,
                  chatbotAddFlow/3,
                  chatbotsVerifier/2,
                  getChatbotFromList/3,
                  chatbotGetElements/6]).
:-use_module(flow).


%Clausulas de Horn
%Base de conocimiento

%Reglas

%Predicado
% chatbot(ChatbotId,Name,WelcomeMessage,StartFlowId,Flows,Chatbot)
% Dominio:
%ChatbotId(int) X Name (string) X WelcomeMessage (string) X
%StartFlowId (int) X Flows (list of flows) X Chatbot (TDA chatbot)
%Meta primaria: chatbot/6
%Metas secundarias:
%integer/1 , string/1, flowsVerifier/2
chatbot(CbotID, Name, WelcMens, StartFlowID, Flows, Chatbot):-
    integer(CbotID),
    string(Name),
    string(WelcMens),
    integer(StartFlowID),
    flowsVerifier(Flows,RevFlows),
    Chatbot = [CbotID, Name, WelcMens, StartFlowID, RevFlows].

%Predicado
% chatbotGetElements(ChatbotId,Name,WelcomeMessage,StartFlowId,Flows,Chatbot)
%Dominio:
%Chatbot (TDA chatbot) X ChatbotId(int) X Name (string) X WelcomeMessage (string) X
%StartFlowId (int) X Flows (list of flows)
%Meta primaria: chatbotGetElements/6
chatbotGetElements([E1,E2,E3,E4,E5,_], E1, E2, E3, E4, E5).

%Predicado
% chatbotAddFlow(Chatbot,Flow,Chatbot)
%Dominio:
%Chatbot (TDA chatbot) X Flow (TDA flow) X Chatbot (TDA chatbot)
%Meta primaria: chatbotAddFlow/3
%Metas secundarias:
%chatbotGetElements/6 , addFlow/3 , flowsVerifier/2 , chatbot/6
chatbotAddFlow(CbotIni,Flow,CbotFin):-
    chatbotGetElements(CbotIni, E1, E2, E3, E4, Flows),
    addFlow(Flow,Flows,ResFlows),
    flowsVerifier(ResFlows,FlowsFin),
    chatbot(E1,E2,E3,E4,FlowsFin,CbotFin).

%Predicado
% addFlow(Flows,Flow,Flows)
%Dominio:
%Flows (list of flows) X Flow (TDA flow) X Flows (list of flows)
%Meta primaria: addFlow/3
%Metas secundarias: addFlow/3
addFlow(Flow,[],[Flow]).
addFlow(Flow,[H|T],[H|ResFlows]):-
    addFlow(Flow,T,ResFlows).

%Predicado
% chatbotsVerifier(Chatbots, Chatbots)
% Dominio:
% Chatbots (list of chatbots) X Chatbots (list of chatbots)
% Meta primaria: chatbotsVerifier/2
% Metas secundarias:
% chatbotGetElements/6 , chatbot/6 , chatbotIsNotDuplicated/2 , chatbotsVerifier/2
chatbotsVerifier([],[]).
chatbotsVerifier([Cbot|Res],[Cbot2|Rest]):-
    chatbotGetElements(Cbot,Id,E2,E3,E4,E5),
    chatbot(Id,E2,E3,E4,E5,Cbot2),
    chatbotIsNotDuplicated(Id,Res),
    chatbotsVerifier(Res,Rest).

%Predicado
% chatbotIsNotDuplicated(ChatbotId,Chatbots)
%Dominio:
%ChatbotId (int) X Chatbots (list of chatbots)
% Meta primaria: chatbotIsNotDuplicated
% Metas secunadias: chatbotGetElements/2 , \=/2 , chatbotIsNotDuplicated/2
chatbotIsNotDuplicated(_,[]).
chatbotIsNotDuplicated(Id,[Cbot|Res]):-
    chatbotGetElements(Cbot,Id2,_,_,_,_),
    Id \= Id2,
    chatbotIsNotDuplicated(Id,Res).

%Predicado
% getChatbotFromList(ChatbotId, Chatbots, Chatbot)
% Dominio:
% ChatbotId (int) , Chatbots (list of chatbots) , Chatbot (TDA chatbot)
% Meta primaria: getChatbotFromList/3
% Metas secundarias: chatbotGetElements/6, !/0
getChatbotFromList(CbotId, [Cbot|_], Cbot):-
    chatbotGetElements(Cbot,CbotId,_,_,_,_),!.
% Metas secundarias: getChatbotFromList/3
getChatbotFromList(CbotId,[_|Chatbots],Cbot):-
    getChatbotFromList(CbotId,Chatbots,Cbot).
