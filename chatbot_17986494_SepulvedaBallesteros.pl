:-module(chatbot_17986494_SepulvedaBallesteros, [chatbot/6,
                                                 chatbotAddFlow/3,
                                                 chatbotsVerifier/2,
                                                 getChatbotFromList/3,
                                                 chatbotGetElements/6]).
:-use_module(flow_17986494_SepulvedaBallesteros).


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
chatbotGetElements([E1,E2,E3,E4,E5], E1, E2, E3, E4, E5).

%Predicado chatbotAddFlow
% chatbotAddFlow(Chatbot,Flow,Chatbot)
%Dominio:
%Chatbot (TDA chatbot) X Flow (TDA flow) X Chatbot (TDA chatbot)
%Meta primaria: chatbotAddFlow/3
%Metas secundarias:
% chatbotGetElements/6 , chatbotAddFloeRec/3 , chatbot/6
chatbotAddFlow(CbotIni,Flow,CbotFin):-
    chatbotGetElements(CbotIni, E1, E2, E3, E4, Flows),
    chatbotAddFlowRec(Flow,Flows,FlowsFin),           %Función recursiva auxiliar que añade Flows
    chatbot(E1,E2,E3,E4,FlowsFin,CbotFin).
% chatbotAddFlowRec(Flow,Flows,Flows)
%Dominio: Flow (TDA flow) X Flows (list of flows) X Flows (list of flows)
% Meta primaria: chatbotAddFlowRec/3
% Metas secundarias: flowGetElements/2 , \=/2 , =/2 , chatbotAddFlowRec/3
chatbotAddFlowRec(Flow,[],[Flow]).
chatbotAddFlowRec(Flow,[KeepFlow|Flows],[KeepFlow|FlowsAcum]):-
    flowGetElements(Flow,FlowId,_,_),
    flowGetElements(KeepFlow,KeepFlowId,_,_),
    FlowId \= KeepFlowId,
    chatbotAddFlowRec(Flow,Flows,FlowsAcum).
chatbotAddFlowRec(Flow,[KeepFlow|Flows],Flows):-
    flowGetElements(Flow,FlowId,_,_),
    flowGetElements(KeepFlow,KeepFlowId,_,_),
    FlowId = KeepFlowId.

%Predicado
% chatbotsVerifier(Chatbots, Chatbots)
% Dominio:
% Chatbots (list of chatbots) X Chatbots (list of chatbots)
% Meta primaria: chatbotsVerifier/2
% Metas secundarias:
% chatbotGetElements/6 , chatbot/6 , chatbotIsNotDuplicated/2 , chatbotsVerifier/2 , \+/1
chatbotsVerifier([],[]).
chatbotsVerifier([Chatbot|Resto],[Chatbot|ChatbotAcum]):-
    chatbotGetElements(Chatbot,Id,_,_,_,_),
    chatbotIsNotDuplicated(Id,Resto),     %No hay duplicados
    chatbotsVerifier(Resto,ChatbotAcum).
chatbotsVerifier([Cbot|Resto],ChatbotAcum):-
    chatbotGetElements(Cbot,Id,_,_,_,_),
    \+ chatbotIsNotDuplicated(Id,Resto),  %Encontrar duplicados
    chatbotsVerifier(Resto,ChatbotAcum).


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
