% H
h(l(_), 1).

h(st(R, _, S), N) :-
	length(R, NR), % numero di robot
	h_qord(S, HO),
	h_qporta(S, HP),
	h_arm(S, HA),
	h_banco(S, HB),
	h_viaggi(S, HV),
	N is ceiling((HO + HP + HA + HB + HV) / (NR)).

h_qord(S, HO) :-
	mult_fact(MF), % fattore per cui moltiplicare i pesi
	count_ord(S, QO), % quantità ordini in sospeso
	HO is (QO * 2 * MF). % ordini pesano il doppio (articolo va raccolto e depositato)
h_qporta(S, HP) :-
	mult_fact(MF), % fattore per cui moltiplicare i pesi
	count_porta(S, QP), % quantità articoli da riportare
	HP is QP * MF. % peso per scarico articoli
h_arm(S, HA) :-
	count_arm(S, NA), % numero armadi da visitare
	HA1 is NA * 4 * 2,
	HA2 is ceiling(NA / 3) * 4 * 2,
	HA is HA1 + HA2 + 4.
h_banco(S, HB) :-
	check_porta(S, NP), % verifica se robot che trasp. devono ancora andare al banco
	HB is NP * 10.
h_viaggi(S, HV) :-
	count_ord(S, QO), % quantità ordini in sospeso
	capacita(Cap),
	QO1 is ceiling(QO / Cap),
	HV is QO1 * 10 * 2.

% count_ord(+L, -Q)
% significato: nello stato S sono stati ordinati Q elementi
count_ord(S, Q) :-
	count_ord(S, 0, Q).
count_ord([], Acc, Acc).
count_ord([ordine(_, Q)|C], PQ, NQ) :-
	!,
	NQ1 is PQ + Q,
	count_ord(C, NQ1, NQ).
count_ord([_|C], PQ, NQ) :-
	count_ord(C, PQ, NQ).
% count_porta(+S, -Q)
% significato: nello stato S, Q elementi sono caricati sui robot
count_porta(S, Q) :-
	count_porta(S, 0, Q).
count_porta([], Acc, Acc).
count_porta([porta(_, _, Q)|C], PQ, NQ) :-
	!,
	NQ1 is PQ + Q,
	count_porta(C, NQ1, NQ).
count_porta([_|C], PQ, NQ) :-
	count_porta(C, PQ, NQ).

check_porta(S, 1) :-
	ord_memberchk(porta(R, _, _), S),
	\+ord_memberchk(posizione(R, l(b)), S),
	!.
check_porta(_, 0).
% count_arm(+S, -N)
% significato: nello stato S vanno ancora visitati N armadi
count_arm(S, N) :-
	list_arm(S, [], L),
	length(L, N).
list_arm(S, Acc, Acc) :-
	\+ord_memberchk(ordine(_, _), S),
	!.
list_arm(S, OldL, NewL) :-
	ord_memberchk(ordine(Art, _), S),
	contiene(Arm, Art, _),
	\+ord_memberchk(posizione(_, l(Arm)), S),
	remove_art(S, Art, S1),
	ord_union(OldL, [l(Arm)], NewL1),
	list_arm(S1, NewL1, NewL),
	!.
list_arm(S, OldL, NewL) :-
	ord_memberchk(ordine(Art, _), S),
	contiene(Arm, Art, _),
	ord_memberchk(posizione(_, l(Arm)), S),
	remove_art(S, Art, S1),
	list_arm(S1, OldL, NewL),
	!.
remove_art(S, Art, S) :-
	\+ord_memberchk(ordine(Art, _), S),
	!.
remove_art(S, Art, NS) :-
	ord_memberchk(ordine(Art, Q), S),
	ord_subtract(S, [ordine(Art, Q)], S1),
	remove_art(S1, Art, NS).
