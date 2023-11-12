%TDA System
%Representación: Lista
%Name (string)
%ChatbotCode (int)
%Chatbots (list of chatbots)
%Userlist (list of users)
%User (string / integer)


%Predicado constructor de un nuevo sistema
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

%Predicado especial para reconstruir sistemas ya creados.
% system(Name,InitialChatbotCodeLink,Chatbots,Userlist,User,System)
%Dominio: Name (string) X InitialChatbotCodeLink (int) X Chatbots (list of
% chatbots) X Userlist (list uf users) X User (string) System (TDA system)
% Meta primaria: system/6
system(N,ICCL,CB,Userlist,User,System):-
    System = [N,ICCL,CB,Userlist,User].

%Predicado Modificador
%Añade un nuevo chatbot al sistema. Verifica que no esté duplicado.
% systemAddChatbot(System,Chatbot,System)
%Dominio: System (TDA system) X Chatbot (TDA chatbot) X System (TDA system)
% Meta primaria: systemAddChatbot/3
% Metas secundarias: systemGetElements/6 , append/3 , chatbotsVerifier/2 , system/6
systemAddChatbot(SystemIni,Chatbot,SystemFin):-
    systemGetElements(SystemIni,E1,E2,ChatbotsIni,E4,E5),
    append(ChatbotsIni,[Chatbot],Chatbots),
    chatbotsVerifier(Chatbots,ChatbotsFin),
    system(E1,E2,ChatbotsFin,E4,E5,SystemFin).
% Este predicado permite manejar el caso de agregar duplicados,
% devolviendo el mismo sistema sin cambios en caso de intentar agregar
% un chatbot con ID ya existente en el sistema
%systemAddChatbot(System,Chatbot,System):-
%    systemGetElements(System,_,_,Chatbots,_,_),
%    append(Chatbots,[Chatbot],ChatbotsFin),
%    \+ chatbotsVerifier(ChatbotsFin,_).

%Predicado Modificador
% Registra un nuevo usuario en el sistema creando un TDA user, evitando
% la duplicación de usuarios con igual username
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
% Esta clausula permite manejar el caso de agregar un usuario ya existente
%systemAddUser(System,_,System).

% Predicado para que un usuario inicie sesión en el sistema. Evita
% iniciar sesión si el usuario no está registrado o si ya hay una sesión
% systemLogin(System,User,System)
%Dominio: System (TDA system) X User (string) X System (TDA system)
% Meta primaria: systemLogin/3
% Metas secundarias: systemGetElements/6 , !/0 , userInList/2
systemLogin(System,User,SystemLog):-
    systemGetElements(System,E1,E2,E3,Userlist,0),!,
    userInList(User,Userlist),
    system(E1,E2,E3,Userlist,User,SystemLog).
% Esta clausula permite manejar el caso de intentar iniciar sesión en
% caso de que el usuario no esté en el sistema o que ya exista una
% sesión iniciada.
%systemLogin(System,_,System).

%Predicado que finaliza la sesión de un usuario en el sistema
% systemLogout(System,System)
%Dominio: System (TDA system) X System (TDA system)
% Meta primaria: systemLogout/2
% Metas secundarias: systemGetElements/6 , system/5
systemLogout(System,SystemOut):-
    systemGetElements(System,E1,_,E3,Userlist,_),
    system(E1,0,E3,Userlist,0,SystemOut).       %Un 0 en la última posición de system marca que no hay sesión iniciada
% Caso que permite manejar intento de logout cuando no hay una sesión iniciada
%systemLogout(System,System).

%Predicado systemTalkRec
% systemTalkRec(System,Message,System)
%Dominio: System (TDA system) X Message (string) X System (TDA system)
% Meta primaria: system/3
%Caso: no hay usuario logeado
% Metas secundarias: \+/1 , systemGetElements/6
% Si no hay usuario logeado no se puede interactuar con un chatbot. Este
% predicado permitiría manejar la situación manteniendo el sistema.
%systemTalkRec(System,_,System):-
%    systemGetElements(System,_,_,_,_,User),
%    \+ string(User).

%Caso: mensaje NO es una opción válida.
% Metas secundarias: systemGetElements/6 , userInList/3 , getChatbotFromList/3
% chatbotGetElements/6 , getFlowFromList/3 , \+/2 , get_time/1 ,
% format_time/3 , msgInOpionList/4 , =/2 , append/3 , user/3 ,
% updateUserChatH/3 , system/6
systemTalkRec(System, Msg, SystemT):-
    systemGetElements(System,E1,CbotCodeLink,Chatbots,UserlistIni,User),
    getChatbotFromList(CbotCodeLink,Chatbots,Chatbot),  %Encontrar Chatbot asociado
    chatbotGetElements(Chatbot,_,_,_,FlowCode,Flows),
    getFlowFromList(FlowCode,Flows,Flow),     %Encontrar Flow actual
    flowGetElements(Flow,FlowCode,_,Oplist),
    \+ msgInOptionList(Msg,Oplist,_,_),       %Mensaje NO es una opción válida
    get_time(T),
    format_time(string(Time),'%FT%T%:z',T),
    Chat = [Time,CbotCodeLink,FlowCode,Msg],    %Construir Elemento de Chat
    getUserChatH(User,UserlistIni,ChatHIni),     %Obtener ChatHistory de User
    append(ChatHIni,[Chat],ChatHFin),           %Agregar elemento de Chat a ChatHistory
    user(User,ChatHFin,UserF),                %Actualizar UserF
    updateUserChatH(UserF,UserlistIni,UserlistFin), %Actualizar Userlist
    system(E1,CbotCodeLink,Chatbots,UserlistFin,User,SystemT).

%Caso: mensaje SI es una opción válida
% Metas secundarias: systemGetElements/6 , userInList/3 , getChatbotFromList/3
% chatbotGetElements/6 , getFlowFromList/3 , msgInOpionList/4 ,
% get_time/1 , format_time/3 , =/2 append/3 , user/3 , updateUserChatH/3 ,
% updateChatbotFlowCode/4 , system/6
systemTalkRec(System,Msg,SystemT):-
    systemGetElements(System,E1,CbotCodeLinkIni,Chatbots,UserlistIni,User),
    getChatbotFromList(CbotCodeLinkIni,Chatbots,Chatbot),  %Encontrar Chatbot asociado
    chatbotGetElements(Chatbot,_,_,_,FlowId,Flows),
    getFlowFromList(FlowId,Flows,Flow),     %Encontrar Flow actual
    flowGetElements(Flow,FlowId,_,Oplist),
    msgInOptionList(Msg,Oplist,NewCbotCodeLink,NewFlowId),       %Mensaje SI es una opción válida
    get_time(T),
    format_time(string(Time),'%FT%T%:z',T),
    Chat = [Time,NewCbotCodeLink,NewFlowId,Msg],    %Construir Elemento de Chat
    getUserChatH(User,UserlistIni,ChatHIni),     %Obtener ChatHistory de User
    append(ChatHIni,[Chat],ChatHFin),           %Agregar elemento de Chat a ChatHistory
    user(User,ChatHFin,UserF),                %Actualizar UserF
    updateUserChatH(UserF,UserlistIni,UserlistFin), %Actualizar Userlist
    updateChatbotFlowCode(NewCbotCodeLink,NewFlowId,Chatbots,ChatbotsFin),
    system(E1,NewCbotCodeLink,ChatbotsFin,UserlistFin,User,SystemT).

% Predicados auxiliares a SystemTalkRec
% **************************************
% Predicado que actualiza el historial de chat de un usuario
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
% Predicado que actualiza el chatbot cargado en el sistema tras una interacción
% updateChatbotFlowCode(ChatbotCodeLink,FlowId,Chatbots,Chatbots)
% Dominio: ChatbotCodeLink (int) X FlowId (int) X Chatbots (list of
% chatbots) X Chatbots (list of chatbots) Meta primaria:
% updateChatbotFlowCode/4 Metas secundarias: getChatbotFromList/3 ,
% chatbotGetElements/6 , chatbot/6 , replaceChatbot/4
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

%*******************************

%Predicado que entrega la síntesis de interacciones de un usuario como string
% systemSyhthesis(System,User,Str)
%Dominio: System (TDA system) X  User (string) X Str (string)
% Meta primaria: systemSynthesis/3
% Metas secundarias: systemGetElements/6 , getUserChatH/3 , formatChatH/5
systemSynthesis(System, User, Str):-
    systemGetElements(System, _, _, Chatbots, Userlist, _),
    getUserChatH(User,Userlist,ChatH),
    formatChatH(User, Chatbots, ChatH,"", Str).

%Predicado formatChatH
% Construye recursivamente el string de síntesis a partir de los string
% de interacción que construye chatToStr
% formatChatH(User,Chatbots,ChatH,StrAcc,FormatedStr)
%Dominio: User (string) X Chatbots (list of chatbots) X ChatH (TDA chathistory) X
%StrAcc (string) X FormatedStr (string)
% Meta primaria: formatChatH/5
% Metas secundarias: getChatbotFromList/3 , chatbotGetElements/6 ,
% getFlowFromList/3 , flowGetElements/4 , chatToStr/7 , string_concat/3 , formatChatH/5
formatChatH(_,_,[],StrRes,StrRes).
formatChatH(User,Chatbots,[[Time,CbotId,FlowId,Msg]|ChatH],StrAcum,StrRes):-
    getChatbotFromList(CbotId,Chatbots,Chatbot),
    chatbotGetElements(Chatbot,_,CbotName,_,_,Flows),
    getFlowFromList(FlowId,Flows,Flow),
    flowGetElements(Flow,_,FlowMens,Oplist),
    chatToStr(User,Time,Msg,CbotName,FlowMens,Oplist,ChatStr),
    string_concat(StrAcum,ChatStr,StrTemp),
    string_concat(StrTemp,"\n",StrAcumNew),
    formatChatH(User,Chatbots,ChatH,StrAcumNew,StrRes).


%Predicado systemSimulate
% Genera una simulación de cierta cantidad de interacciones a partir de
% una semilla, guardando las interacciones en el chatHistory correspondiente
% systemSimulate(System,maxInteractions,Seed,System)
%Dominio: System (TDA system) X maxInteractions (int) X
%Seed (int) X System (TDA system)
% Meta primaria: systemSimulate/4
% Metas secundarias: number_string/2 , string_concat/3 , systemAddUser/3 ,
% systemLogin/3 , interList/4 , simulating/3
%Tras terminar simulación, devuelve el sistema sin sesión iniciada
systemSimulate(System, 0, _, System).
systemSimulate(SysIni, MaxInter, Seed, System):-
    number_string(Seed,StrSeed),
    string_concat("user",StrSeed,UserName),
    systemAddUser(SysIni,UserName,SysUser), %Registrar usuario simulado
    systemLogin(SysUser,UserName,SysLog),   %Iniciar sesión de usuario simulado
    interList(MaxInter,Seed,[],List),       %Generar lista aleatoria
    simulating(SysLog,List,SysSimul),       %Generar simulación
    systemLogout(SysSimul,System).          %Cerrar sesión tras la simulación

% Predicados auxiliares a SystemSimulate
% **************************************

%Predicado simulating
% Genera las simulaciones de forma recursiva para pasarlas a systemSimulate
% Utiliza generateMens para obtener un mensaje para ejecutar systemTalkRec
% simulating(System,List,System)
%Dominio: System (TDA % system) X List (list) X System (TDA system)
% Meta primaria: simulating/3
% Metas secundarias: generateMens/3 , systemTalkRec/3 , simulating/3
simulating(System,[],System).
simulating(SysIni,[Rand|Rest],SysFin):-
    generateMens(SysIni,Rand,Msg),
    systemTalkRec(SysIni,Msg,SysNext),
    simulating(SysNext,Rest,SysFin).
simulating(System,[_|Rest],System):-
    simulating(System,Rest,System).

%Predicado generateMens
% Predicado auxiliar para generar una opción aleatoria válida a partir
% de un número aleatorio
% generateMens(System,Rand,Mens)
%Dominio: System (TDA system) X Rand (int) X Mens (string)
% Meta primaria: generateMens/3 Metas
% secundarias: systemGetElements/6 , getChatbotFromList/3 ,
% chatbotGetElements/6 , getFlowFromList/3 , flowGetElements/4
% randMens/2 , msgInOptionList/4
generateMens(System,Rand,Msg):-
    systemGetElements(System,_,CbotCode,Chatbots,_,_),
    getChatbotFromList(CbotCode,Chatbots,Chatbot),  %Encontrar Chatbot asociado
    chatbotGetElements(Chatbot,_,_,_,FlowId,Flows),
    getFlowFromList(FlowId,Flows,Flow),     %Encontrar Flow actual
    flowGetElements(Flow,_,_,Oplist),
    randMens(Rand,Msg),
    msgInOptionList(Msg,Oplist,_,_).
% Caso alternativo para seguir buscando un mensaje válido
generateMens(System,Rand,Msg):-
    NRand is Rand / 10,
    NRand > 10,
    generateMens(System,round(NRand),Msg).
% Forzar mensaje de error para detectar situaciones no deseadas
generateMens(_,_,"IDK").


%Predicado para generar, a partir de un número aleatorio, un mensaje en
% el rango del 1 al 10, que podría servir como opción para systemTalkRec
% randMens(Rand,Mens)
%Dominio: Rand (int) X Mens (string)
% Meta primaria: randMens/2
% Metas secundarias:
randMens(Rand,Mens):-
    Aux is Rand mod 10,
    number_string(Aux,Mens).

% Predicado myRandom
%Genera un número pseudoaleatorio a partir de una
% semilla myRandom(Seed, RandNum) Dominio: Seed (int) X RandNum (int)
% Meta primaria: myRandom/2 Metas secundarias: */2 , +/2 , is/2 , mod/2
myRandom(Xn, Xn1):-
    Xn1 is (1103515245 * Xn + 12345) mod 2147483648.

%Predicado interList
%Construye una lista con una secuencia de MaxInteractions números pseudoaleatorios
% interList(MaxInteractions,Seed,List,List)
%Dominio: MaxInteractions (int) X Seed (int) List (list) X List (list)
% Meta primaria: interList/4
% Metas secundarias: >/2 , myRandom/2 , is/2 , -/2 , interList/4
interList(0,_,List,List).
interList(MaxInter,Seed,Resto,Lista):-
    MaxInter > 0,
    myRandom(Seed,Rand),
    NextInter is MaxInter - 1,
    interList(NextInter, Rand,[Rand|Resto],Lista).

%Predicado selector
% systemGetElements(System,Name,InitialChatbotCodeLink,Chatbots,Userlist,User)
% Meta primaria: systemGetElemets/6
%Dominio: System (TDA system) X Name (string) X InitialChatbotCodeLink (int) X
% Chatbots (list of chatbots) X Userlist (list of user) X User (string)
systemGetElements([E1,E2,E3,E4,E5],E1,E2,E3,E4,E5).
