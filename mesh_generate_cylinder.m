function m = mesh_generate_cylinder()
r = 1;
m.C = [1;2;3;4];
m.P = 1;
m.K = 1;
m.B = ones(4,1);
m.V =[-1,1,-1,1;-1,-1,1,1];
m.R = [1;2;3;4];

f = @(x,y) [r*cos(pi*x);
            r*sin(pi*x);
            y];
m.M = {f};
f = @(x,y) [pi*(-r*sin(pi*x)), 0;
            pi*r*cos(pi*x), 0;
            0, 1];
m.J = {f};
m.refLevel = 0;