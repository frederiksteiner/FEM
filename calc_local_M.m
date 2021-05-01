function Mt = calc_local_M(p1, p2, p3, p4,DPj)
N1 = @(x,y) (1 - x)*(1 - y)/4; dxN1 = @(x,y) -(1-y)/4; dyN1 = @(x,y) -(1-x)/4;
N2 = @(x,y) (1 + x)*(1 - y)/4; dxN2 = @(x,y) (1-y)/4;  dyN2 = @(x,y) -(1+x)/4;
N3 = @(x,y) (1 - x)*(1 + y)/4; dxN3 = @(x,y) -(1+y)/4; dyN3 = @(x,y) (1-x)/4;
N4 = @(x,y) (1 + x)*(1 + y)/4; dxN4 = @(x,y) (1+y)/4;  dyN4 = @(x,y) (1+x)/4;

Fj1 = @(x,y) N1(x,y) * p1(1) + N2(x,y) *p2(1) + N3(x,y) * p3(1) + N4(x,y) * p4(1);
Fj2 = @(x,y) N1(x,y) * p1(2) + N2(x,y) *p2(2) + N3(x,y) * p3(2) + N4(x,y) * p4(2);
DFj = @(x,y) [dxN1(x,y)*p1(1), dyN1(x,y)*p1(1); dxN1(x,y)*p1(2), dyN1(x,y)*p1(2)] + ...
    [dxN2(x,y)*p2(1), dyN2(x,y)*p2(1); dxN2(x,y)*p2(2), dyN2(x,y)*p2(2)] +...
    [dxN3(x,y)*p3(1), dyN3(x,y)*p3(1); dxN3(x,y)*p3(2), dyN3(x,y)*p3(2)] + ...
    [dxN4(x,y)*p4(1), dyN4(x,y)*p4(1); dxN4(x,y)*p4(2), dyN4(x,y)*p4(2)]; 
DFj = @(x,y) DFj(x,y)'; %geändert
Tj = @(x,y) (DPj(Fj1(x,y),Fj2(x,y))*DFj(x,y))'*(DPj(Fj1(x,y),Fj2(x,y))*DFj(x,y));
% x = -1:0.1:1;
% y = x;
% x= 1;
% y = 1;
% [X,Y]=meshgrid(x,x);
Z11 = @(x,y) N1(x,y)^2*sqrt(det(Tj(x,y)));
Z12 = @(x,y) N1(x,y)*N2(x,y)*sqrt(det(Tj(x,y)));
Z13 = @(x,y) N1(x,y)*N3(x,y)*sqrt(det(Tj(x,y)));
Z14 = @(x,y) N1(x,y)*N4(x,y)*sqrt(det(Tj(x,y)));
Z22 = @(x,y) N2(x,y)^2*sqrt(det(Tj(x,y)));
Z23 = @(x,y) N2(x,y)*N3(x,y)*sqrt(det(Tj(x,y)));
Z24 = @(x,y) N2(x,y)*N4(x,y)*sqrt(det(Tj(x,y)));
Z33 = @(x,y) N3(x,y)^2*sqrt(det(Tj(x,y)));
Z34 = @(x,y) N3(x,y)*N4(x,y)*sqrt(det(Tj(x,y)));
Z44 = @(x,y) N4(x,y)^2*sqrt(det(Tj(x,y)));
% m11 = trapz(y,trapz(x,Z11(X,Y),2));
% m12 = trapz(y,trapz(x,Z12(X,Y),2));
% m13 = trapz(y,trapz(x,Z13(X,Y),2));
% m14 = trapz(y,trapz(x,Z14(X,Y),2));
% m22 = trapz(y,trapz(x,Z22(X,Y),2));
% m23 = trapz(y,trapz(x,Z23(X,Y),2));
% m24 = trapz(y,trapz(x,Z24(X,Y),2));
% m33 = trapz(y,trapz(x,Z33(X,Y),2));
% m34 = trapz(y,trapz(x,Z34(X,Y),2));
% m44 = trapz(y,trapz(x,Z44(X,Y),2));
m11 = trapez2d(Z11,0);
m12 = trapez2d(Z12,0);
m13 = trapez2d(Z13,0);
m14 = trapez2d(Z14,0);
m22 = trapez2d(Z22,0);
m23 = trapez2d(Z23,0);
m24 = trapez2d(Z24,0);
m33 = trapez2d(Z33,0);
m34 = trapez2d(Z34,0);
m44 = trapez2d(Z44,0);
Mt = [m11, m12, m13, m14;...
     m12, m22, m23, m24;...
     m13, m23, m33, m34;...
     m14, m24, m34, m44];

