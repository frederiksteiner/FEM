function x = trapez2d(f,subdiv)
n = 2^subdiv;



x = (f(-1,-1) + f(-1,1) + f(1,-1) + f(1,1));

