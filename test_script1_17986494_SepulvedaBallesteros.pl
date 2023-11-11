:-use_module(option_17986494_SepulvedaBallesteros, [option/6 as t_option]).
:-use_module(flow_17986494_SepulvedaBallesteros, [flow/4 as t_flow,
                                                  flowAddOption/3 as t_flowAddOption]).
:-use_module(chatbot_17986494_SepulvedaBallesteros, [chatbot/6 as t_chatbot,
                                                     chatbotAddFlow/3 as t_chatbotAddFlow]).
:-use_module(system_17986494_SepulvedaBallesteros, [system/4 as t_system,
                                                    systemAddChatbot/3 as t_systemAddChatbot,
                                                    systemAddUser/3 as t_systemAddUser,
                                                    systemLogin/3 as t_systemLogin,
                                                    systemLogout/2 as t_systemLogout,
                                                    systemTalkRec/3 as t_systemTalkRec,
                                                    systemSynthesis/3 as t_systemSynthesis,
						    systemSimulate/4 as t_systemSimulate]).


test(S8,S9,S10,S11):-
t_option(1, "1-via", 2, 4, ["via", "cono"], O1),
t_option(2, "2-estu", 4, 3, ["apre"], O2),
%t_option(2, "3-trab", 3, 2, ["chamb", "ganar"], O3),
t_flow(1, "flujo 1: prueba", [ ], F1),
t_flow(4, "flujo 4: prueba", [O1, O2], F2),
t_flowAddOption(F2, O2, F3),
t_flowAddOption(F1, O1, F5),
t_flowAddOption(F5, O2, _),
%F2 = F3 = F6 true
t_chatbot(0, "Asist", "Bienvenido", 1, [F5], CB),
t_chatbot(1, "What", "Otra cosa", 1, [F2,F3], CB2),
t_chatbot(2, "OtroCbot", "Welcome", 1, [F2,F3], CB3),

t_chatbotAddFlow(CB, F3,CB11),
t_system("NewSystem", 0, [CB], S0),
t_system("NewSystem", 0, [CB11,CB2], S1),
length(S0,A),
length(S1,B),
A = B,
t_systemAddChatbot(S0, CB3, S2),
t_systemAddUser(S2, "user0", S3),
t_systemAddUser(S3, "user1", S4),
t_systemLogin(S4,"user0",S5),
t_systemLogin(S5,"user1",S6),
S5 = S6,
t_systemLogout(S6, S7),
S7 = S4,
t_systemTalkRec(S7,"hola",S8),
S7 = S8,
t_systemLogin(S8,"user1",S9),
t_systemTalkRec(S9,"hola",S10),
t_systemTalkRec(S10,"1",S11),
t_systemSynthesis(S11,"user1",Str),
write(Str),
t_systemLogout(S11,S12),
t_systemSimulate(S12,4,3122,S13),
t_systemSynthesis(S13,"user3122",Str2),
write(Str2).
