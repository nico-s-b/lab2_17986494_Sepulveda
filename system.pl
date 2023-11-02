:-module(system, [system/4,
                 systemAddChatbot/3,
                 systemAddUser/3]).

:-use_module(chatbot).
:-use_module(user).

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
% system(Name,InitialChatbotCodeLink,Chatbots,System)
% system(Name,InitialChatbotCodeLink,Chatbots,Userlist,System)
% system(Name,InitialChatbotCodeLink,Chatbots,Userlist,User,System)
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

%Metas
%Primarias
%system/4
%systemAddChatbot/3
%systemAddUser/3
%systemLogin/3
%systemLogout/2
%systemTalkRec/3
%systemSynthesis/3
%systemSimulate/4

%Secundarias
%system/5
%system/6
%systemGetElements/4
%systemGetElements/5
%systemGetElements/6
%saveUserActivity/2

system(Name, IniCbotCodeLink, Chatbots,System):-
    string(Name),
    integer(IniCbotCodeLink),
    chatbotsVerifier(Chatbots, RevChatbots),
    System = [Name, IniCbotCodeLink, RevChatbots,_,_].

system(N,ICCL,CB,Userlist,System):-
    System = [N,ICCL,CB,Userlist].

system(N,ICCL,CB,Userlist,User,System):-
    System = [N,ICCL,CB,Userlist,User].

systemGetElements(System,E1,E2,E3):-
    nth0(0, System, E1),
    nth0(1, System, E2),
    nth0(2, System, E3).
systemGetElements(System,E1,E2,E3,E4):-
    systemGetElements(System,E1,E2,E3),
    nth0(3, System, E4).
systemGetElements(System,E1,E2,E3,E4,E5):-
    systemGetElements(System,E1,E2,E3,E4),
    nth0(4, System, E5).

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
    systemGetElements(System,E1,E2,E3,Userlist,User),
    saveUserActivity(User,Userlist),
    system(E1,E2,E3,Userlist,SystemOut).
systemLogout(System,System).

systemAddUser(SystemIni,User,SystemFin):-
    systemGetElements(SystemIni,E1,E2,E3,UserlistIni),
    user(User,UserF),
    append(UserlistIni,UserF,Userlist),
    usersVerifier(Userlist,UserlistFin),
    system(E1,E2,E3,UserlistFin,SystemFin).
