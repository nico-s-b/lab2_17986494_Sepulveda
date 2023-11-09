:-module(user_17986494_SepulvedaBallesteros, [user/2,
                                              user/3,
                                              userInList/2,
                                              getUserChatH/3]).
:-use_module(chathistory_17986494_SepulvedaBallesteros).
%Dominios
%Username = string
%User = list (TDA user)
%Userlist = list

%Predicado constructor
% user(Username, User)
%Dominio: Username (string) X User (TDA user)
% Meta primaria: user/2
% Metas secundarias: string/1 , =/2
user(Username, UserF):-
    string(Username),
    ChatHistory = [],
    UserF = [Username, ChatHistory].
%Predicado
% user(Username, ChatHistory, User)
%Dominio: Username (string) X ChatHistory (TDA chathistory) X User (TDA user)
% Meta primaria: user/3
% Metas secundarias: string/1 , chatVerifier/1 , =/2
user(Username,ChatHistory,UserF):-
    string(Username),
    chatVerifier(ChatHistory),
    UserF = [Username, ChatHistory].

%Predicado
% userInList(User, Userlist)
%Domino: User (string) X Userlist (list of users)
% Meta primaria: userInList/2
% Metas secundarias: userInList/2
userInList(User,[[User,_]|_]).
userInList(User,[_|List]):-
    userInList(User,List).

%Predicado selector
% getUserChatH(User,Userlist,ChatHistory)
%Dominio: User (string) X Userlist (list of users) X ChatHistory (TDA chathistory)
% Meta primaria: getUserChatH/3
% Metas secundarias: getUserChatH/3
getUserChatH(User,[[User,ChatH]|_],ChatH).
getUserChatH(User,[_|List],ChatH):-
    getUserChatH(User,List,ChatH).
