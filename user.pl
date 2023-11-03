:-module(user, [user/2,
               usersVerifier/2,
               userInList/2]).
:-use_module(chathistory).
%Dominios
%Username = string
%User = list (TDA user)
%Userlist = list

user(Username, UserF):-
    string(Username),
    ChatHistory = [],
    UserF = [Username, ChatHistory].

usersVerifier([],[]).
userVerifier(User,[[U|Chat]|Userlist]):-
    not(userInList(User,Userlist)).

userInList(User,[[User,_]|_]).
userInList(User,[_|List]):-
    userInList(User,List).
