:-module(user, [user/2,
               usersVerifier/2
               userInList/2]).


user(Username, UserF):-
    string(Username),
    ChatHistory = [],
    UserF = [Username, ChatHistory].

usersVerifier([],[]).

userInList(User,Userlist).
