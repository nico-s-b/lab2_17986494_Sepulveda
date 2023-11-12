%Ejemplo para mostrar funciones mínimas
option(1,"1) Viajar",1,1,["viajar","turistear","conocer"],OP1),
option(2,"2) Comer",2,1,["eat","almorzar","chanchear"],OP2),
flow(1,"flujo1",[OP1,OP2],F10),
%flowAddOption(F10,OP1,F11), %se intenta añadir opción duplicada
chatbot(0,"Inicial","Bienvenido\n¿Qué te gustaría hacer?",1,[F10],CB0),
option(1,"1) Pizza",2,1,["pizza"],OP3),
option(2,"2) Hamburguesa",2,1,["hamburguesa","cuarto de libra"],OP4),
flow(1,"¿Qué quieres comer?",[OP3,OP4],F2),
flow(1,"¿Qué quieres tomar",[OP3,OP4],F3),
% chatbot(1,"Segundo","¿Qué quieres comer?",1,[F2,F3],CB1),
% No permite añadir F2 y F3, pues a pesar de ser distintos tienen el mismo ID
chatbot(2,"Segundo","¿Qué quieres comer?",1,[F2],CB1),
% system("Chatbots Paradigmas",0,[CB0,CB0,CB0],S0), %No permite añadir
% más de una vez el mismo chatbot
system("Chatbots Paradigmas",0,[CB0,CB1],S0),
%systemAddChatbot(S0,CB0,S1), %igual a s0
systemAddUser(S0,"user1",S2),
systemAddUser(S2,"user2",S3),
%systemAddUser(S3,"user2",S4), %no permite añadir otra vez a user2
systemAddUser(S3,"user3",S5),
%systemLogin(S5,"user8",S6), %user8 no existe. No inicia sesión
systemLogin(S5,"user1",S7),
% systemLogin(S7,"user2",S8), %no permite iniciar sesión a user2, pues
% user1 ya inició sesión
systemLogout(S7,S9),
systemLogin(S9,"user2",S10),
systemTalkRec(S10,"Hola",S11),
systemTalkRec(S11,"2",S12),
systemSynthesis(S12,"user2",Str),
systemLogout(S12,S13),
systemSimulate(S13,2,12345,S14).
