function [M, A] = matrices_assemble_2(m)

I = sparse(zeros(4, 0));
J = sparse(zeros(4, 0));

V_m = sparse(zeros(4, 0));
V_a = sparse(zeros(4, 0));

N = cell(1, 4);
N{1} = @(x,y) 1/4*(1-x)*(1-y);
N{2} = @(x,y) 1/4*(1+x)*(1-y);
N{3} = @(x,y) 1/4*(1-x)*(1+y);
N{4} = @(x,y) 1/4*(1+x)*(1+y);

grad_N = cell(1, 4);
grad_N{1} = @(x,y) [-1/4*(1-y); -1/4*(1-x)];
grad_N{2} = @(x,y) [ 1/4*(1-y); -1/4*(1+x)];
grad_N{3} = @(x,y) [-1/4*(1+y);  1/4*(1-x)];
grad_N{4} = @(x,y) [ 1/4*(1+y);  1/4*(1+x)];

for j = 1:size(m.C, 2)
    % get the p's
    P = zeros(2, 4);
    
    for i = 1:4
        P(:, i) = m.V(:, m.R(i, m.K(j)));
    end
    
    F = @(x,y) P(:, 1)*N{1}(x,y) + P(:, 2)*N{2}(x,y)...
           + P(:, 3)*N{3}(x,y) + P(:, 4)*N{4}(x,y);
       
    DF = @(x,y) P(:, 1)*grad_N{1}(x,y).' + P(:, 2)*grad_N{2}(x,y).'...
            + P(:, 3)*grad_N{3}(x,y).' + P(:, 4)*N{4}(x,y).';
    
    F1 = @(x,y) N{1}(x,y) * P(1,1) + N{2}(x,y) *P(1,2) + N{3}(x,y) * P(1,3) + N{4}(x,y) * P(1,4);
    F2 = @(x,y) N{1}(x,y) * P(2,1) + N{2}(x,y) *P(2,2) + N{3}(x,y) * P(2,3) + N{4}(x,y) * P(2,4);
    T = @(x,y) (m.J{m.P(j)}(F1(x,y),F2(x,y))*DF(x,y)).' * (m.J{m.P(j)}(F1(x,y),F2(x,y))*DF(x,y));
%     T = @(x,y) (DPj(Fj1(x,y),Fj2(x,y))*DFj(x,y))'*(DPj(Fj1(x,y),Fj2(x,y))*DFj(x,y));
    M_j = zeros(4, 4);
    A_j = zeros(4, 4);
    
    for r = 1:4
        f = @(x,y) N{r}(x,y)^2 * sqrt(det(T(x,y)));
        M_j(r, r) = trapez2d(f, 0);
    end
    
    for r = 1:4
        for s = r:4
            f = @(x,y) grad_N{s}(x,y).'*(T(x,y)\grad_N{r}(x,y))*sqrt(det(T(x,y)));
            A_j(r, s) = trapez2d(f,0);
            
            if r ~= s
                A_j(s, r) = A_j(r, s);
            end
        end
    end
    
    I(:, 4*j-3:4*j) = [m.C(:, j), m.C(:, j), m.C(:, j), m.C(:, j)];
    J(:, 4*j-3:4*j) = I (:, 4*j-3:4*j).';
    V_m(:, 4*j-3:4*j) = M_j;
    V_a(:, 4*j-3:4*j) = A_j;
end
    
    
M = sparse(I(:), J(:), V_m(:));
A = sparse(I(:), J(:), V_a(:));