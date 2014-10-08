% Strategia scelta
:- consult(astar).

% dominio problema
:- consult(commesso).

% database
:- consult(db1).

% calcolo il piano reltivo agli Ordini in ingresso e lo mostro in
% output
show_piano(Robot,Ordini) :-
	piano(Robot, Ordini, Piano, EndState, Costo),
	nl,
	%mult_fact(MF),
	%MF1 is MF - 1,
	%ord_sum(Ord),
	%ExC is Ord * MF1 * 2,
	%TrueC is Costo - ExC,
	maplist(write,['Piano di costo ', Costo, ':\n']),
	maplist(writeln,Piano),
	nl,
	writeln('Stato finale:'),
	maplist(writeln, EndState).

% mostra base di dati
show_db :-
	nl,
	writeln('Distanze:'),
	listing(dist),
	nl,
	writeln('Contenuto armadi:'),
	listing(contiene).

% mostra distanze calcolate dinamicamente
show_cd :-
	nl,
	writeln('Distanze calcolate durante l\'esecuzione:'),
	listing(calc_dist),
	nl.

% azzera distanze calcolate
reset_cd :-
	retractall(calc_dist(_, _, _)).
% mostra fattore moltiplicativo costi
show_mf :-
	nl,
	mult_fact(MF),
	maplist(write, ['Fattore moltiplicativo costi: ', MF]),
	nl.

% cambia valore del fattore moltiplicativo
change_mf(MF) :-
	retractall(mult_fact(_)),
	assert(mult_fact(MF)),
	show_mf.
% mostra capacità di trasporto robot
show_cap :-
	nl,
	capacita(Cap),
	maplist(write, ['Capacità robot: ', Cap]),
	nl.

% cambia valore capacità robot
change_cap(Cap) :-
	retractall(capacita(_)),
	assert(capacita(Cap)),
	show_cap.
% Interfaccia utente

% Spiegare all'utente cosa puo' fare con questa interfaccia
:-
	nl,
	writeln('==================== COMANDI ===================='),
	nl,
	writeln('show_piano(R:list(robot), Ordini:list((articolo, quantità)))'),
	writeln('con robot    --> r(num)'),
	writeln('con articolo --> art(num)'),
	nl,
	writeln('show_db mostra contenuto db'),
	nl,
	writeln('show_cd mostra distanze calcolate dinamicamente'),
	nl,
	writeln('reset_cd azzera distanze calcolate dinamicamente'),
	nl,
	writeln('show_mf mostra fattore moltiplicativo usato per costi'),
	nl,
	writeln('change_mf(NewMF) cambia il valore del fattore moltiplicativo'),
	nl,
	writeln('show_cap mostra la capacità di trasporto dei robot'),
	nl,
	writeln('change_cap(NewCap) cambia la capacità di trasporto dei robot'),
	nl,
	writeln('================================================='),
	nl,
	reset_cd,
	show_mf,
	show_cap,
	nl.


% chiamata dell'algoritmo di ricerca per il
% calcolo del piano utilizzando l'input dell'interfaccia

% piano(+R:robot, +Ordini:list(articolo), -Piano:list(azione),
% -Costo:real)
% Piano = sequenza di azioni

piano(Robots, Ordini, Piano, EndSt, Costo) :-
	maplist(ord, Ordini, OrdR),  % costruisco la lista di ordini per Robot
	solve(st(Robots, starting, OrdR), nc(G, L, Costo)), % lancio l'algoritmo di ricerca
	extract_state(G, EndSt),
	reverse([G|L],RL),		    % estraggo il piano dalla lista
	maplist(extract_act, RL, Piano).    % [G|L]

% estrae l'azione
extract_act(st(_,Azione,_), Azione).
% estrae stato
extract_state(st(_, _, S), S).
% costruisce l'ordine per Robot
ord((Articolo, Quantita), ordine(Articolo, Quantita)).








