function [L, BB, midPInd] = halbierung(m, E, K, I)
BB = m.B;
n = length(m.B);
midPInd =  zeros(1,size(m.C,2));
for i = 1:length(E)
    for j=1:K(i)
%         p1 = P(:,i);
%         p2 = P(:, E(j,i));
%         pnew = (p2 + p1)/2;  
%         PP = [PP,pnew];
        n = n + 1;
        L(j,i) = n;
        if I(j,i) == 1
            BB(L(j,i)) = 1;
        else
            BB(L(j,i)) = max(m.B(i), m.B(E(j,i))); %% min oder max ? 
        end
    end
end
for i = 1:size(m.C,2)
    n = n + 1;
    midPInd(i) = n;
    BB(n) = 1;
end
