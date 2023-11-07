:-use_module(option_17986494_SepulvedaBallesteros, [option/6 as t_option]).
:-use_module(flow, [flow/4 as t_flow,
		   flowAddOption/3 as t_flowAddOption]).
:-use_module(chatbot_17986494_SepulvedaBallesteros, [chatbot/6 as t_chatbot,
                      chatbotAddFlow/3 as t_chatbotAddFlow]).
:-use_module(system_17986494_SepulvedaBallesteros, [system/4 as t_system,
                     systemAddChatbot/3 as t_systemAddChatbot,
                     systemAddUser/3 as t_systemAddUser,
                     systemLogin/3 as t_systemLogin,
                     systemLogout/2 as t_systemLogout]).

test(F2,F3,F6,S0):-
t_option(1, "1-via", 2, 4, ["via", "cono"], O1),
t_option(2, "2-estu", 4, 3, ["apre"], O2),
t_option(2, "3-trab", 3, 2, ["chamb", "ganar"], O3),
t_flow(1, "flujo 1: prueba", [ ], F1),
t_flow(1, "flujo 1: prueba", [O1, O2], F2),
t_flowAddOption(F2, O3, F3),
t_flowAddOption(F1, O1, F5),
t_flowAddOption(F5, O2, F6),
F2 = F3,
t_chatbot(0, "Asist", "Bienvenido", 1, [F1], CB).

%t_chatbotAddFlow(CB, F5,CB11),
%t_system("NewSystem", 0, [ ], S0),
%t_system("NewSystem", 1, CB11, S1),
%t_systemAddChatbot(S0, CB11, S1),
%S0 = S1,
%t_systemAddUser(S1, "user0", S2),
%t_systemAddUser(S2, "user1", S3),
%t_systemLogin(S3,"user0",S4),
%t_systemLogin(S4,"user1",S5),
%S4 = S5,
%t_systemLogout(S5, S6),
%S6 = S3.


