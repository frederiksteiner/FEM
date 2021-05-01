m = mesh_generate_disk();
for i = 1:3
    m = mesh_refine(m);
end


p1 = 0; p2 = 0; a = 0.01; b = 0.005; c = 1; d = 1; e = 0.06; f = 0.04; T = 4; dt = 10^(-4)/4;
u0f = @(x,y) L(x,y,p1,p2)*0.5 + (1-L(x,y,p1,p2))*1;
v0f = @(x,y) L(x,y,p1,p2)*0.25;
[uh, vh, ts, gs, uplots] = gray_scott(a, b, c, d, e, f, m, u0f, v0f, dt, T);
for i = 1:length(uplots)
    clf
    mesh_function_plot3d(uplots{i},m);
    title(sprintf('%dt plot',i));
    drawnow;
end
function y = L(x,y,p1,p2)
p = [p1;p2];
x0 = [x;y];
if norm(x0-p) < 0.3
    y = 1;
else
    y = 0;
end

end