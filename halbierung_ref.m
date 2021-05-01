function [VV, L, midP, midPInd] = halbierung_ref(E, K, V, R)
VV = V;
midP =  zeros(2, size(R,2));
midPInd = zeros(1, size(R,2));
for i = 1:length(E)
    for j=1:K(i)
        p1 = V(:,i);
        p2 = V(:, E(j,i));
        pnew = (p2 + p1)/2;  
        VV = [VV,pnew];
        L(j,i) = length(VV);
    end
end

for i = 1:size(R,2)
    p1 = V(:,R(1,i));
    p2 = V(:,R(2,i));
    p3 = V(:,R(3,i));
    p4 = V(:,R(4,i));
    midP(:,i) = 1/2*((p1 + p2)/2 + (p3 + p4)/2);
    VV = [VV,midP(:,i)];
    midPInd(i) = length(VV);
end
end
    
