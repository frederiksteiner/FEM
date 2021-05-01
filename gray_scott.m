function [uh, vh, ts, gs,uplots] = gray_scott(a, b, c, d, e, f, m, u0f, v0f, dt, T)
ts = 0:dt:T;
[A,M] = matrices_assemble(m);
uh  = compute_nodal_interpolation(u0f, m);
vh = compute_nodal_interpolation(v0f, m);
gs = zeros(length(ts),1);
k = 1; ulength = floor(length(ts)/100);
uplots = cell(1,ulength);
for i = 1:length(ts)
    vec = (uh.*vh.^2);
    u = M\(-a*A*uh) - c*vec + e*(1 - uh);
    v = M\(-b*A*vh) + d*vec - (f+e)*vh; % ist k in den Notizen
    uh = uh + dt*u;
    vh = vh + dt*v;
    gs(i) = norm(u,Inf);
    if (mod(i,100) == 0)
        uplots{k} = uh;
        k = k + 1;
    end
end
