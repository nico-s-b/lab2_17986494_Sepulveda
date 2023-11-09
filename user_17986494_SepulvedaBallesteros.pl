:-module(user_17986494_SepulvedaBallesteros, [user/2,
                                              user/3,
                                              userInList/2,
                                              getUserChatH/3]).
:-use_module(chathistory_17986494_SepulvedaBallesteros).
%Dominios
%Username = string
%User = list (TDA user)
%Userlist = list

user(Username, UserF):-
    string(Username),
    ChatHistory = [],
    UserF = [Username, ChatHistory].
user(Username,ChatHistory,UserF):-
    string(Username),
    chatVerifier(ChatHistory),
    UserF = [Username, ChatHistory].

userInList(User,[[User,_]|_]).
userInList(User,[_|List]):-
    userInList(User,List).
getUserChatH(User,[[User,ChatH]|_],ChatH).
getUserChatH(User,[_|List],ChatH):-
    getUserChatH(User,List,ChatH).
