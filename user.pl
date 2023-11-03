:-module(user, [user/2,
               usersVerifier/2,
               userInList/2]).
:-use_module(chathistory).
%Dominio

user(Username, UserF):-
    string(Username),
    ChatHistory = [],
    UserF = [Username, ChatHistory].

usersVerifier([],[]).
userVerifier(User,[[U|Chat]|Userlist]):-
    User \= U.

userInList(User,Userlist).
