ureal = @(x,y) 1 - x.^2 - y.^2;
m = mesh_generate_diskseg();
ur = {};
u = {};
n = 6;
errL2 = zeros(n,1);
errH1 = zeros(n,1);
for i = 1:n
    m = mesh_refine(m);
    P = get_Point_list(m);
    [A,M] = matrices_assemble(m);
    ub = zeros(length(A),1);
    idxs = m.B ~= 0;
    f = 4*M*ones(length(M),1);
%     ub(idxs) = A(idxs,idxs)\zeros(length(ub(idxs)),1);
    ub(idxs) = A(idxs,idxs)\f(idxs);
    u{end + 1} = ub;
    uk = ureal(P(1,:),P(2,:))';
    ur{end + 1} = uk;
    errL2(i) = sqrt((ub - uk)'*M*(ub-uk));
    errH1(i) = sqrt((ub - uk)'*M*(ub-uk) + (ub-uk)'*A*(ub-uk));
end
semilogy(1:n,errL2,'o-', 1:n, errH1,'x-', 1:n, 2.^(-(1:n)),1:n, 4.^(-(1:n)));
legend('L2 - error', 'H1 - error');
