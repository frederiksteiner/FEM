function [V,R] = refine_ref(m)
[E,K,I] = edge_list_ref(m.R, size(m.V,2));
[V, L, midP, midPInd] = halbierung_ref(E, K, m.V, m.R);
R = new_el_list_ref(m.R, E, L, midPInd);
end