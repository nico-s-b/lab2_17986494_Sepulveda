:-module(system_17986494_SepulvedaBallesteros, [system/4,
                                                systemAddChatbot/3,
                                                systemAddUser/3,
                                                systemLogin/3,
                                                systemLogout/2,
                                                systemTalkRec/3]).

:-use_module(option_17986494_SepulvedaBallesteros).
:-use_module(flow_17986494_SepulvedaBallesteros).
:-use_module(chatbot_17986494_SepulvedaBallesteros).
:-use_module(user_17986494_SepulvedaBallesteros).

%Predicado system
% system(Name,InitialChatbotCodeLink,Chatbots,System)
%Dominio:
% Name (string) X InitialChatbotCodeLink (int) X Chatbots (list of
% chatbots) X System (TDA system)
% Meta primaria: system/4
% Metas secundarias: string/1 , integer/1 , chatbotsVerifier/2
system(Name, IniCbotCodeLink, Chatbots,System):-
    string(Name),
    integer(IniCbotCodeLink),
    chatbotsVerifier(Chatbots, RevChatbots),
    System = [Name, IniCbotCodeLink, RevChatbots,[],0].

% system(Name,InitialChatbotCodeLink,Chatbots,Userlist,User,System)
%Dominio:
% Name (string) X InitialChatbotCodeLink (int) X Chatbots (list of
% chatbots) X Userlist (list uf users) X User (string) System (TDA system)
% Meta primaria: system/6
system(N,ICCL,CB,Userlist,User,System):-
    System = [N,ICCL,CB,Userlist,User].

% Predicado systemGetElements
% systemGetElements(System,Name,InitialChatbotCodeLink,Chatbots,Userlist,User)
% Meta primaria: systemGetElemets/6
% Dominio: System (TDA system) X Name (string) X InitialChatbotCodeLink (int) X
% Chatbots (list of chatbots) X Userlist (list of user) X User (string)
systemGetElements([E1,E2,E3,E4,E5],E1,E2,E3,E4,E5).

%Predicado
% systemAddChatbot(System,Chatbot,System)
%Dominio: System (TDA system) X Chatbot (TDA chatbot) X System (TDA system)
% Meta primaria: systemAddChatbot/3
% Metas secundarias: systemGetElements/6 , append/3 , chatbotsVerifier/2 , system/6
systemAddChatbot(SystemIni,Chatbot,SystemFin):-
    systemGetElements(SystemIni,E1,E2,ChatbotsIni,E4,E5),
    append(ChatbotsIni,[Chatbot],Chatbots),
    chatbotsVerifier(Chatbots,ChatbotsFin),
    system(E1,E2,ChatbotsFin,E4,E5,SystemFin).
systemAddChatbot(System,Chatbot,System):-
    systemGetElements(System,_,_,Chatbots,_,_),
    append(Chatbots,[Chatbot],ChatbotsFin),
    \+ chatbotsVerifier(ChatbotsFin,_).

%Predicado
% systemAddUser(System,User,System)
%Dominio: System (TDA system) X User (string) X System (TDA system)
% Meta primaria: systemAddUser/3
% Metas secundarias: systemGetElements/5 , user/2 , append/3 , \+/1
% userInList/2 , system/5
systemAddUser(SystemIni,User,SystemFin):-
    systemGetElements(SystemIni,E1,E2,E3,UserlistIni,E5),
    \+ userInList(User,UserlistIni),
    user(User,UserF),
    append(UserlistIni,[UserF],Userlist),
    system(E1,E2,E3,Userlist,E5,SystemFin).
systemAddUser(System,_,System).

%Predicado
% systemLogin(System,User,System)
%Dominio: System (TDA system) X User (string) X System (TDA system)
% Meta primaria: systemLogin/3
% Metas secundarias: systemGetElements/6 , !/0 , userInList/2
systemLogin(System,User,SystemLog):-
    systemGetElements(System,E1,E2,E3,Userlist,0),!,
    userInList(User,Userlist),
    system(E1,E2,E3,Userlist,User,SystemLog).
systemLogin(System,_,System).

%Predicado
% systemLogout(System,System)
%Dominio: System (TDA system) X System (TDA system)
% Meta primaria: systemLogout/2
% Metas secundarias: systemGetElements/6 , system/5
systemLogout(System,SystemOut):-
    systemGetElements(System,E1,E2,E3,Userlist,_),
    system(E1,E2,E3,Userlist,0,SystemOut).       %Un 0 en la última posición de system marca que no hay sesión iniciada
systemLogout(System,System).

%Predicado systemTalkRec
% systemTalkRec(System,Message,System)
%Dominio: System (TDA system) X Message (string) X System (TDA system)
% Meta primaria: system/3
%Caso: no hay usuario logeado
% Metas secundarias: \+/1 , systemGetElements/6
% Si no hay usuario logeado no se puede interactuar con un chatbot
systemTalkRec(System,_,System):-
    systemGetElements(System,_,_,_,_,User),
    \+ string(User).
%Caso: mensaje NO es una opción válida
% Metas secundarias: systemGetElements/6 , userInList/3 , getChatbotFromList/3
% chatbotGetElements/6 , getFlowFromList/3 , \+/2 , msgInOpionList/4 , =/2 ,
% append/3 , user/3 , updateUserChatH/3 , system/6
systemTalkRec(System, Msg, SystemT):-
    systemGetElements(System,E1,CbotCodeLink,Chatbots,UserlistIni,User),
    getChatbotFromList(CbotCodeLink,Chatbots,Chatbot),  %Encontrar Chatbot asociado
    chatbotGetElements(Chatbot,_,_,_,FlowCode,Flows),
    getFlowFromList(FlowCode,Flows,Flow),     %Encontrar Flow actual
    flowGetElements(Flow,FlowCode,_,Oplist),
    \+ msgInOptionList(Msg,Oplist,_,_),       %Mensaje NO es una opción válida
    Chat = [CbotCodeLink,FlowCode,Msg],    %Construir Elemento de Chat
    getUserChatH(User,UserlistIni,ChatHIni),     %Obtener ChatHistory de User
    append(ChatHIni,[Chat],ChatHFin),           %Agregar elemento de Chat a ChatHistory
    user(User,ChatHFin,UserF),                %Actualizar UserF
    updateUserChatH(UserF,UserlistIni,UserlistFin), %Actualizar Userlist
    system(E1,CbotCodeLink,Chatbots,UserlistFin,User,SystemT).
%Caso: mensaje SI es una opción válida
% Metas secundarias: systemGetElements/6 , userInList/3 , getChatbotFromList/3
% chatbotGetElements/6 , getFlowFromList/3 , msgInOpionList/4 , =/2
% append/3 , user/3 , updateUserChatH/3 , updateChatbotFlowCode/4 , system/6
systemTalkRec(System,Msg,SystemT):-
    systemGetElements(System,E1,CbotCodeLinkIni,Chatbots,UserlistIni,User),
    getChatbotFromList(CbotCodeLinkIni,Chatbots,Chatbot),  %Encontrar Chatbot asociado
    chatbotGetElements(Chatbot,_,_,_,FlowId,Flows),
    getFlowFromList(FlowId,Flows,Flow),     %Encontrar Flow actual
    flowGetElements(Flow,FlowId,_,Oplist),
    msgInOptionList(Msg,Oplist,NewCbotCodeLink,NewFlowId),       %Mensaje SI es una opción válida
    Chat = [NewCbotCodeLink,NewFlowId,Msg],    %Construir Elemento de Chat
    getUserChatH(User,UserlistIni,ChatHIni),     %Obtener ChatHistory de User
    append(ChatHIni,[Chat],ChatHFin),           %Agregar elemento de Chat a ChatHistory
    user(User,ChatHFin,UserF),                %Actualizar UserF
    updateUserChatH(UserF,UserlistIni,UserlistFin), %Actualizar Userlist
    updateChatbotFlowCode(NewCbotCodeLink,NewFlowId,Chatbots,ChatbotsFin),
    system(E1,NewCbotCodeLink,ChatbotsFin,UserlistFin,User,SystemT).

%Predicado
% updateUserChatH(Chatbot,Chatbots,Chatbots)
%Dominio: Chatbot (TDA chatbot) X Chatbots (list of chatbots) X Chatbots (list of chatbots)
% Meta primaria: updateUserChatH/3
% Metas secundarias: updateUserChatH/3 , \=/2
updateUserChatH(_,[],[]).
updateUserChatH([Username,NewChatH],[[Username,_]|Userlist],[[Username,NewChatH]|UserlistFin]):-
    updateUserChatH([Username,NewChatH],Userlist,UserlistFin).
updateUserChatH([Username,NewChatH],[[Username2,ChatH2]|Userlist],[[Username2,ChatH2]|UserlistFin]):-
    Username \= Username2,
    updateUserChatH([Username,NewChatH],Userlist,UserlistFin).

%Predicado
% updateChatbotFlowCode(ChatbotCodeLink,FlowId,Chatbots,Chatbots)
%Dominio: ChatbotCodeLink (int) X FlowId (int) X Chatbots (list of
%chatbots) X Chatbots (list of chatbots)
% Meta primaria: updateChatbotFlowCode/4
% Metas secundarias: getChatbotFromList/3 , chatbotGetElements/6 ,
% chatbot/6 , replaceChatbot/4
updateChatbotFlowCode(CbCode,FlowId,Chatbots,ChatbotsFin):-
    getChatbotFromList(CbCode,Chatbots,Chatbot),
    chatbotGetElements(Chatbot,E1,E2,E3,_,E5),
    chatbot(E1,E2,E3,FlowId,E5,ChatbotFin),
    replaceChatbot(CbCode,ChatbotFin,Chatbots,ChatbotsFin).

%Predicado
% replaceChatbot(ChatbotCodeLink,Chatbot,Chatbots,Chatbots)
%Dominio: ChatbotCodeLink (int) X Chatbot (TDA chatbot) X Chatbots
%(list of chatbots) X Chatbots (list of chatbots)
% Meta primaria: replaceChatbot/4
% Metas secundarias: =/2 , \=/2 , replaceChatbot/4
replaceChatbot(_,_,[],[]).
replaceChatbot(CbCode,ChatbotFin,[[CbCode,_,_,_,_]|Chatbots],[ChatbotFin|ChatbotsAcum]):-
    replaceChatbot(CbCode,ChatbotFin,Chatbots,ChatbotsAcum).
replaceChatbot(CbCode,ChatbotFin,[Chatbot2|Chatbots],[Chatbot2|ChatbotsAcum]):-
    Chatbot2 = [CbCode2,_,_,_,_],
    CbCode \= CbCode2,
    replaceChatbot(CbCode,ChatbotFin,Chatbots,ChatbotsAcum).

%Predicado
% systemSyhthesis(System,User,Str)
%Dominio: System (TDA system) X User (string) X Str (string)
% Meta primaria: systemSynthesis/3
