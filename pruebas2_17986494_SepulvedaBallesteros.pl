%Ejemplo detallado de un sistema de chatbots basado en el esquema del
% enunciado general Opciones del unico flujo Chatbot0
option(1,"1) Calendario", 1, 1 ,["fechas" ,"calendario" ,"dias"],OP1),
option(2,"2) Tareas",2,1,["tareas","pendientes","tasks"],OP2),
option(3,"3) Metas",3,1,["meta","metas","Objetivos"],OP3),
% flow(1,"Flujo Principal Organizador\nBienvenido\n¿Qué te gustaría revisar",[OP1,OP2,OP2], F11), %Falla al intentar agregar más de una opción
flow(1,"Flujo Principal Organizador\nBienvenido\n¿Qué te gustaría revisar",[OP1,OP2], F12),
%flowAddOption
%flowAddOption(F11,OP1,F12), %se intenta añadir opción duplicada, fallando
flowAddOption(F12,OP3,F13),
%chatbot(0,"Inicial" "Bienvenido\n¿Qué te gustaría revisar",1,[F13,F13],CB0), %falla al intentar añadir flujos repetidos
chatbot(0,"Inicial", "Bienvenido\n¿Qué te gustaría revisar",1,[F13],CB0),

%Chatbot1
%Opciones primer flujo Chatbot1
option(1,"1) 1 día",1,2,["dia","diario"],OP4),
option(2,"2) 1 semana",1,2,["semana","semanal"],OP5),
option(3,"3) 1 mes",1,2,["mes","mensual"],OP6),
option(4,"4) Volver",0,1,["Regresar","Salir","Volver"],OP7),
%Opciones segundo flujo Chatbot1
option(1,"1) Resaltar tareas",1,1,["tareas"],OP8),
option(2,"2) Resaltar eventos",1,1,["eventos"],OP9),
option(3,"3) Resaltar cumpleaños",1,1,["cumpleaños","cumples"],OP10),
option(4,"4) Volver",0,1,["Regresar","Salir","Volver"],OP11),
%Flujos Chatbot 1
flow(1,"Flujo 1 Chatbot1\nElige ventana de tiempo del calendario",[OP4,OP5,OP6],F20),
flowAddOption(F20,OP7,F21),
flow(2,"Flujo 2 Chatbot1\n¿Deseas resaltar algo del calendario?",[OP8,OP9,OP10,OP11],F22),
chatbot(1,"Calendario", "Elige ventana de tiempo del calendario",1,[F21,F22],CB1),

%Chatbot2
%Flujo 1
option(1,"1) Ver listado de tareas",2,2,["ver","Listado","Tareas"],OP12),
option(2,"2) Añadir tarea",2,1,["agregar","añadir","add"],OP13),
option(3,"3) Eliminar tarea",2,1,["eliminar","borrar","remove"],OP14),
option(4,"4) Volver",0,1,["Regresar","Salir","Volver"],OP15),
%Flujo 2
option(1,"1) Por prioridad",0,1,["prioridad","importancia"],OP16),
option(2,"1) Por fecha",0,1,["tiempo","dia","fecha"],OP17),
option(3,"1) Por estado",0,1,["estado"],OP18),
option(4,"4) Volver",1,1,["Regresar","Salir","Volver"],OP19),
%Flujos Chatbot 2
flow(1,"Flujo 1 Chatbot2\n¿Qué te gustaría hacer con las tareas?",[OP12,OP13,OP14,OP15],F30),
flow(2,"Flujo 2 Chatbot2\n¿De qué forma quieres filtrar las tareas?",[OP16,OP17,OP18,OP19],F31),
chatbot(2,"Tareas" ,"Bienvenido\n¿Qué te gustaría hacer con las tareas?",1,[F30],CB2),
%chatbotAddFlow
chatbotAddFlow(CB2,F31,CB3),   %agregar flow de forma recursiva, añadiendo una sola ocurrencia
% chatbotAddFlow(CB3,F31,CB4), %fallará al intentar agregar flujo repetido

%Chatbot3 Flujo1
option(1,"1) Ver metas",0,1,["ver","Listado","metas"],OP20),
option(2,"2) Cambiar meta",0,1,["modificar","cambiar"],OP21),
option(3,"3) Asignar meta",0,1,["asignar","nueva","añadir"],OP22),
option(4,"4) Volver",0,1,["Regresar","Salir","Volver"],OP23),
flow(1,"Flujo 1 Chatbot3\n¿Qué te gustaría hacer con las metas?",[],F401), %Crear flow sin opciones
flowAddOption(F401,OP20,F402),    %Rellenar flow después de crearlo
flowAddOption(F402,OP21,F403),    %Rellenar flow después de crearlo
flowAddOption(F403,OP22,F404),    %Rellenar flow después de crearlo
flowAddOption(F404,OP23,F41),    %Rellenar flow después de crearlo

chatbot(3,"Metas", "Bienvenido\n¿Qué te gustaría hacer con las metas?",1,[],CB4), %Crear chatbot sin flows
chatbotAddFlow(CB4,F41,CB5),     %Rellenar chatbot tras crearlo

%Sistema
%system("Chatbot Organizador",0,[CB0,CB1,CB1,S0), %Fallará al crear un sistema con chatbot duplicados
system("Chatbot Organizador",0,[CB0,CB1],S0),
%systemAddChatbot
systemAddChatbot(S0,CB3,S1),
systemAddChatbot(S1,CB5,S2),
%systemAddChatbot(S2,CB5,S3), %debiera fallar al intentar agregar duplicados

%systemAddUser
systemAddUser(S2,"user1",S4),
%systemAddUser(S4,"user1",S5), %Retorna false pues "user1" ya está en el sistema
systemAddUser(S4,"user2",S6),
systemAddUser(S6,"user3",S7),

%systemLogin & logout
systemLogin(S7,"user2",S8),
systemLogout(S8,S9),
%systemLogout(S8,S9), %Logout no es posible pues no hay sesión iniciada
systemLogin(S9,"user1",S10),
% systemLogin(S10,"user2",S11), %Login no es posible pues ya hay sesión
% iniciada

%user1 interactuando con sistema
%systemTalkRec
systemTalkRec(S10,"hola",S11),
systemTalkRec(S11,"1",S12),
systemTalkRec(S12,"semana",S131),
systemTalkRec(S131,"eventos",S13),
systemTalkRec(S13,"4",S14),
systemLogout(S14,S15),


% systemTalkRec(S15,"hola",S16), %no es posible interactuar pues no hay sesión iniciada
% systemLogin(S16,"user22",S17), %no hay login pues user22 no existe en sistema
systemLogin(S15,"user2",S18),

%user2 interactuando con sistema
systemTalkRec(S18,"que tal?",S19),
systemTalkRec(S19,"3",S20),
systemTalkRec(S20,"ver",S21),
systemTalkRec(S21,"2",S23),
systemTalkRec(S23,"1",S24),
systemTalkRec(S24,"prioridad",S25),
systemTalkRec(S25,"no se",S26),
systemTalkRec(S26,"calendario",S28),
systemLogout(S28,S29),

%systemSynthesis
%síntesis de dos usuarios distintos con chathistory almacenado
systemSynthesis(S29,"user2",Str1),
systemLogin(S29,"user3",S30),
% systemSimulate(S29,6,1234,S100), %No es posible solicitar simulaciones si hay una sesión iniciada
systemSynthesis(S30,"user1",Str2),    %la segunda síntesis se puede solicitar aunque haya otro usuario loggeado
systemSimulate(S4,6,1234,S100),
write(Str2).
