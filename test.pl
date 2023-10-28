:-use_module(option, [option/6 as t_option]).
:-use_module(flow, [flow/4 as t_flow]).

test():-
t_option(1, "1 - viajar", 2, 4, ["viajar", "turistear", "conocer"], O1),
t_option(2, "2 - estudiar", 4, 3, ["aprender", "perfeccionarme"], O2),
t_flow(1, "Flujo 1: mensaje de prueba", [ ], F1),
t_flow(2, "flujo 1: mensaje de prueba", [O1, O2], F2).

