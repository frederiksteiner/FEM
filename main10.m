%% mesh generation
m = mesh_generate_disk();
for i = 1:5
    m = mesh_refine(m);
end

%% Situation 1
p1 = 0.3; p2 = 0.2; a = 0.2; b = 0.1; c = 1000; d = 1000; e = 31; f = 55; T = 4; dt = 10^(-4)/4;
u0f = @(x,y) L(x,y,p1,p2)*0.5 + (1-L(x,y,p1,p2))*1;
v0f = @(x,y) L(x,y,p1,p2)*0.25;
[uh, vh, ts, gs, uplots] = gray_scott(a, b, c, d, e, f, m, u0f, v0f, dt, T);

%% plotting

% for i = 1:length(uplots)
%     clf
%     mesh_function_plot3d(uplots{i},m);
%     title(sprintf('%dt plot',i));
%     drawnow;
% end

figure
mesh_function_plot(uh,m);
figure
mesh_function_plot(vh,m);


%% Situation 2
p1 = 0.3; p2 = 0.3; a = 0.2; b = 0.1; c = 1000; d = 1000; e = 28; f = 55; T = 4; dt = 10^(-4)/4;
u0f = @(x,y) L(x,y,p1,p2)*0.5 + (1-L(x,y,p1,p2))*1;
v0f = @(x,y) L(x,y,p1,p2)*0.25;
[uh, vh, ts, gs, uplots] = gray_scott(a, b, c, d, e, f, m, u0f, v0f, dt, T);
for i = 1:length(uplots)
    clf
    mesh_function_plot3d(uplots{i},m);
    title(sprintf('%dt plot',i));
    drawnow;
end
figure
mesh_function_plot(uh,m);
figure
mesh_function_plot(vh,m);

%% Situation 3
p1 = 0.5; p2 = 0.2; a = 0.2; b = 0.1; c = 1000; d = 1000; e = 280; f = 550; T = 4; dt = 10^(-4)/4;
u0f = @(x,y) L(x,y,p1,p2)*0.5 + (1-L(x,y,p1,p2))*1;
v0f = @(x,y) L(x,y,p1,p2)*0.25;
[uh, vh, ts, gs, uplots] = gray_scott(a, b, c, d, e, f, m, u0f, v0f, dt, T);
for i = 1:length(uplots)
    clf
    mesh_function_plot3d(uplots{i},m);
    title(sprintf('%dt plot',i));
    drawnow;
end
%%
figure
mesh_function_plot(uh,m);
figure
mesh_function_plot(vh,m);

%% Another test
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



%%
figure
mesh_function_plot(uh,m);
figure
mesh_function_plot(vh,m);

%% functions
function y = L(x,y,p1,p2)
p = [p1;p2];
x0 = [x;y];
if norm(x0-p) < 0.3
    y = 1;
else
    y = 0;
end

end

