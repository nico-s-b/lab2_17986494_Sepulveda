:-module(system_17986494_SepulvedaBallesteros, [system/4,
                 systemAddChatbot/3,
                 systemAddUser/3,
                 systemLogin/3,
                 systemLogout/2,
                 systemTalkRec/3]).

%:-use_module(option).
:-use_module(flow).
:-use_module(chatbot_17986494_SepulvedaBallesteros).
:-use_module(user_17986494_SepulvedaBallesteros).

%Dominios
%Name = string
%InitialChatbotCodeLink = integer
%Chatbots = list
%User = string
%UserF = list (TDA user)
%Userlist = list
%Chatbot = list (TDA chatbot)
%Message = string
%String = string
%MaxInteractions = integer
%Seed = integer

%Predicados
% systemGetElements(System,Name,InitialChatbotCodeLink,Chatbots)
% systemGetElements(System,Name,InitialChatbotCodeLink,Chatbots,Userlist)
% systemGetElements(System,Name,InitialChatbotCodeLink,Chatbots,Userlist,User)
% systemAddChatbot(System,Chatbot,System)
% systemAddUser(System,User,System)
% systemLogin(System,User,System)
% systemLogout(System,System)
% systemTalkRec(System,Message,System)
% systemSynthesis(System,User,String)
% systemSimulate(System,MaxInteractions,Seed,System)
% saveUserActivity(User,Userlist)

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
    System = [Name, IniCbotCodeLink, RevChatbots,_,_].

% system(Name,InitialChatbotCodeLink,Chatbots,Userlist,System)
%Dominio:
% Name (string) X InitialChatbotCodeLink (int) X Chatbots (list of
% chatbots) X Userlist (list uf users) X System (TDA system)
% Meta primaria: system/5
system(N,ICCL,CB,Userlist,System):-
    System = [N,ICCL,CB,Userlist].

% system(Name,InitialChatbotCodeLink,Chatbots,Userlist,User,System)
%Dominio:
% Name (string) X InitialChatbotCodeLink (int) X Chatbots (list of
% chatbots) X Userlist (list uf users) X User (string) System (TDA system)
% Meta primaria: system/6
system(N,ICCL,CB,Userlist,User,System):-
    System = [N,ICCL,CB,Userlist,User].


systemGetElements([E1,E2,E3,_],E1,E2,E3).
systemGetElements([E1,E2,E3,E4,_],E1,E2,E3,E4).
systemGetElements([E1,E2,E3,E4,E5,_],E1,E2,E3,E4,E5).

systemAddChatbot(SystemIni,Chatbot,SystemFin):-
    systemGetElements(SystemIni,E1,E2,ChatbotsIni,E4,E5),
    append(ChatbotsIni,Chatbot,Chatbots),
    chatbotsVerifier(Chatbots,ChatbotsFin),
    system(E1,E2,ChatbotsFin,E4,E5,SystemFin).
systemAddChatbot(SystemIni,_,SystemIni).

systemLogin(System,User,SystemLog):-
    systemGetElements(System,_,_,_,_,_),!,
    systemGetElements(System,E1,E2,E3,Userlist),
    userInList(User,Userlist),
    SystemLog = [E1,E2,E3,Userlist,User].
systemLogin(System,_,System).

systemLogout(System,SystemOut):-
    systemGetElements(System,E1,E2,E3,Userlist,_),
    system(E1,E2,E3,Userlist,SystemOut).
systemLogout(System,System).

systemAddUser(SystemIni,User,SystemFin):-
    systemGetElements(SystemIni,E1,E2,E3,UserlistIni),
    user(User,UserF),
    append(UserlistIni,UserF,Userlist),
    \+ userInList(User,Userlist),
    system(E1,E2,E3,Userlist,SystemFin).

%Caso: no hay usuario logeado
systemTalkRec(System,_,System):-
    \+ systemGetElements(System,_,_,_,_,_).
%Caso: mensaje NO es una opción válida
systemTalkRec(System, Msg, SystemT):-
    systemGetElements(System,Name,CbotCodeLinkIni,Chatbots,UserlistIni,User),
    userInList(User,UserlistIni,ChatHIni),     %Obtener ChatHistory de User
    getChatbotFromList(CbotCodeLinkIni,Chatbots,Chatbot),  %Encontrar Chatbot asociado
    chatbotGetElements(Chatbot,_,_,_,FlowCode,Flows),
    getFlowFromList(FlowCode,Flows,Flow),     %Encontrar Flow actual
    flowGetElements(Flow,FlowCode,_,_),
    Chat = [CbotCodeLinkIni,FlowCode,Msg],    %Construir Elemento de Chat
    append(ChatHIni,Chat,ChatHFin),           %Agregar elemento de Chat
    user(User,ChatHFin,UserF),                %Actualizar UserF
    updateUserChatH(UserF,UserlistIni,UserlistFin), %Actualizar Userlist
    system(Name,CbotCodeLinkIni,Chatbots,UserlistFin,User,SystemT).
%Caso: mensaje SI es una opción válida
systemTalkRec(System,Msg,SystemT).


updateUserChatH(_,_,_).
