:-use_module(option, [option/6 as t_option]).
:-use_module(flow, [flow/4 as t_flow,
		   flowAddOption/3 as t_flowAddOption]).

test():-
t_option(1, "1-viajar", 2, 4, ["viajar", "conocer"], O1),
t_option(2, "2-estudiar", 4, 3, ["aprender"], O2),
t_option(2, "3-trabajar", 3, 2, ["chambear", "ganar dinero"], O3),
t_flow(1, "Flujo 1: prueba", [ ], F1),
t_flow(2, "flujo 1: prueba", [O1, O2], F2),
t_flowAddOption(F2, O3, F3).
%t_flowAddOption(F14, O2, F15).


