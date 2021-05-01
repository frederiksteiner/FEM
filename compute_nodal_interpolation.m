function g = compute_nodal_interpolation(gf, m)
P = get_Point_list(m);
g = zeros(size(P,2),1);
dim = size(P,1);
for i = 1:size(P,2)
    if dim == 2
        g(i) = gf(P(1,i),P(2,i));
    else
        g(i) = gf(P(1,i),P(2,i),P(3,i));
    end
end

end

