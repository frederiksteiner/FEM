function m = mesh_refine(m)
numP = length(m.B);
[E,K,I] = edge_list(m, numP);
[L, BB, midPInd] = halbierung(m, E, K, I);
[CC,PP,KK] = new_el_list(m.C, E, L, midPInd, m.P, m.refLevel);
[VV,RR] = refine_ref(m);
m.C = CC;
m.B = BB;
m.R = RR;
m.V = VV;
m.P = PP;
m.K = KK;
m.refLevel = m.refLevel + 1;
end