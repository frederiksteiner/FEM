%% Initialization
m = mesh_generate_cylinder();
for i = 1:6
    m = mesh_refine(m);
end

%% Situation 1
p1 = 1; p2 = 0; p3 = 0.5; a = 0.2; b = 0.1; c = 1000; d = 1000; e = 31; f = 55; T = 4; dt = 10^(-4)/4;
u0f = @(x,y,z) L(x,y,z,p1,p2,p3)*0.5 + (1-L(x,y,z,p1,p2,p3))*1;
v0f = @(x,y,z) L(x,y,z,p1,p2,p3)*0.25;
[uh, vh, ts, gs,uplots] = gray_scott(a, b, c, d, e, f, m, u0f, v0f, dt, T);

%%
for i = 1:length(uplots)
    clf
    mesh_function_plot3d(uplots{i},m);
    title(sprintf('%dt plot',i));
    
    view(-45,70);
    drawnow;
    
end


function y = L(x,y,z,p1,p2,p3)
p = [p1;p2;p3];
x0 = [x;y;z];
if norm(x0-p) < 1.6
    y = 1;
else
    y = 0;
end

end
