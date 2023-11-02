:-use_module(option, [option/6 as t_option]).
:-use_module(flow, [flow/4 as t_flow,
		   flowAddOption/3 as t_flowAddOption]).

test(F2,F3,F6):-
t_option(1, "1-viajar", 2, 4, ["viajar", "conocer"], O1),
t_option(2, "2-estudiar", 4, 3, ["aprender"], O2),
t_option(2, "3-trabajar", 3, 2, ["chambear", "ganar dinero"], O3),
t_flow(1, "flujo 1: prueba", [ ], F1),
t_flow(1, "flujo 1: prueba", [O1, O2], F2),
t_flowAddOption(F2, O3, F3),
t_flowAddOption(F1, O1, F5),
t_flowAddOption(F5, O2, F6),
F2 = F3.

%t_flowAddOption(F14, O2, F15).


