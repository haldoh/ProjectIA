% distanze fra armadi
dist(l(b), l(a1), 10).
dist(l(b), l(a2), 10).
dist(l(b), l(a3), 10).
dist(l(a1), l(a2), 4).
dist(l(a2), l(a3), 4).
dist(l(a1), l(a4), 8).
dist(l(a2), l(a5), 8).
dist(l(a3), l(a6), 8).
dist(l(a4), l(a5), 4).
dist(l(a5), l(a6), 4).
dist(l(a4), l(a7), 8).
dist(l(a5), l(a8), 8).
dist(l(a6), l(a9), 8).
dist(l(a7), l(a8), 4).
dist(l(a8), l(a9), 4).

% posizione articoli
contiene(a1, art(1), 15).
contiene(a1, art(2), 15).
contiene(a2, art(3), 15).
contiene(a2, art(4), 10).
contiene(a3, art(5), 10).
contiene(a3, art(6), 10).
contiene(a4, art(7), 5).
contiene(a4, art(8), 5).
contiene(a5, art(9), 5).
contiene(a5, art(10), 10).
contiene(a6, art(11), 10).
contiene(a6, art(12), 10).
contiene(a7, art(13), 15).
contiene(a7, art(14), 15).
contiene(a8, art(15), 15).
contiene(a8, art(16), 20).
contiene(a9, art(17), 20).
contiene(a9, art(18), 20).

% capacità trasporto robot
capacita(10).
