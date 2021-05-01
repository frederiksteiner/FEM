function [A, M] = matrices_assemble(m)
Vm = zeros(4, 4*size(m.C,2));
Va = zeros(4, 4*size(m.C,2));
J = zeros(4, 4*size(m.C,2));
I = zeros(4, 4*size(m.C,2));
N1 = @(x,y) (1 - x)*(1 - y)/4; dxN1 = @(x,y) -(1-y)/4; dyN1 = @(x,y) -(1-x)/4; dN1 = @(x,y) [dxN1(x,y);dyN1(x,y)];
N2 = @(x,y) (1 + x)*(1 - y)/4; dxN2 = @(x,y) (1-y)/4;  dyN2 = @(x,y) -(1+x)/4; dN2 = @(x,y) [dxN2(x,y);dyN2(x,y)];
N3 = @(x,y) (1 - x)*(1 + y)/4; dxN3 = @(x,y) -(1+y)/4; dyN3 = @(x,y) (1-x)/4;  dN3 = @(x,y) [dxN3(x,y);dyN3(x,y)];
N4 = @(x,y) (1 + x)*(1 + y)/4; dxN4 = @(x,y) (1+y)/4;  dyN4 = @(x,y) (1+x)/4;  dN4 = @(x,y) [dxN4(x,y);dyN4(x,y)];
for k = 1:size(m.C,2)
    stk = m.R(:,m.K(k));
    f = m.M{m.P(k)};
    DPj = m.J{m.P(k)};
    p1 = m.V(:,stk(1));
    p2 = m.V(:,stk(2)); 
    p3 = m.V(:,stk(3)); 
    p4 = m.V(:,stk(4)); 
    Fj1 = @(x,y) N1(x,y) * p1(1) + N2(x,y) *p2(1) + N3(x,y) * p3(1) + N4(x,y) * p4(1);
    Fj2 = @(x,y) N1(x,y) * p1(2) + N2(x,y) *p2(2) + N3(x,y) * p3(2) + N4(x,y) * p4(2);
    DFj = @(x,y) p1*dN1(x,y)' + p2*dN2(x,y)' + p3*dN3(x,y)' + p4*dN4(x,y)';
    Tj = @(x,y) (DPj(Fj1(x,y),Fj2(x,y))*DFj(x,y))'*(DPj(Fj1(x,y),Fj2(x,y))*DFj(x,y));
    Z11 = @(x,y) dN1(x,y)'*(Tj(x,y)\dN1(x,y))*sqrt(det(Tj(x,y)));
    Z12 = @(x,y) dN1(x,y)'*(Tj(x,y)\dN2(x,y))*sqrt(det(Tj(x,y)));
    Z13 = @(x,y) dN1(x,y)'*(Tj(x,y)\dN3(x,y))*sqrt(det(Tj(x,y)));
    Z14 = @(x,y) dN1(x,y)'*(Tj(x,y)\dN4(x,y))*sqrt(det(Tj(x,y)));
    Z22 = @(x,y) dN2(x,y)'*(Tj(x,y)\dN2(x,y))*sqrt(det(Tj(x,y)));
    Z23 = @(x,y) dN2(x,y)'*(Tj(x,y)\dN3(x,y))*sqrt(det(Tj(x,y)));
    Z24 = @(x,y) dN2(x,y)'*(Tj(x,y)\dN4(x,y))*sqrt(det(Tj(x,y)));
    Z33 = @(x,y) dN3(x,y)'*(Tj(x,y)\dN3(x,y))*sqrt(det(Tj(x,y)));
    Z34 = @(x,y) dN3(x,y)'*(Tj(x,y)\dN4(x,y))*sqrt(det(Tj(x,y)));
    Z44 = @(x,y) dN4(x,y)'*(Tj(x,y)\dN4(x,y))*sqrt(det(Tj(x,y)));
    m11 = trapez2d(Z11,0); m12 = trapez2d(Z12,0); m13 = trapez2d(Z13,0); m14 = trapez2d(Z14,0); m22 = trapez2d(Z22,0); m23 = trapez2d(Z23,0); m24 = trapez2d(Z24,0); m33 = trapez2d(Z33,0); m34 = trapez2d(Z34,0); m44 = trapez2d(Z44,0);
%     Vm(:,4*k-3:4*k) = calc_local_M(p1, p2, p3, p4,m.J{m.P(k)}); %% geändert
%     Va(:,4*k-3:4*k) = calc_local_A(p1, p2, p3, p4,m.J{m.P(k)}); %% geändert
    Va(:,4*k-3:4*k) = [m11, m12, m13, m14;...
                       m12, m22, m23, m24;...
                       m13, m23, m33, m34;...
                       m14, m24, m34, m44];
    Z11 = @(x,y) N1(x,y)^2*sqrt(det(Tj(x,y)));
    Z22 = @(x,y) N2(x,y)^2*sqrt(det(Tj(x,y)));
    Z33 = @(x,y) N3(x,y)^2*sqrt(det(Tj(x,y)));
    Z44 = @(x,y) N4(x,y)^2*sqrt(det(Tj(x,y)));
    m11 = trapez2d(Z11,0); m22 = trapez2d(Z22,0); m33 = trapez2d(Z33,0); m44 = trapez2d(Z44,0);
    Vm(:,4*k-3:4*k) =      [m11, 0, 0, 0;...
                            0, m22, 0, 0;...
                            0, 0, m33, 0;...
                            0, 0, 0, m44];
    I(:,4*k-3:4*k) = [m.C(1,k),m.C(1,k),m.C(1,k),m.C(1,k);
                      m.C(2,k),m.C(2,k),m.C(2,k),m.C(2,k);
                      m.C(3,k),m.C(3,k),m.C(3,k),m.C(3,k);
                      m.C(4,k),m.C(4,k),m.C(4,k),m.C(4,k)];
    J(:,4*k-3:4*k) = I(:,4*k-3:4*k)';
end
A = sparse(I(:),J(:), Va(:));
M = sparse(I(:),J(:), Vm(:));
end