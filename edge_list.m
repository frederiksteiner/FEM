function [E,K,I] = edge_list(m, numP)
E = zeros(4, numP);
I = zeros(size(E));
filledEntries = ones(numP,1);
for i = 1:size(m.C,2)
    for j= 1:4
        if j<3
%             p1 = m.C(i,1);
%             p2 = m.C(i,j + 1);
            p1 = m.C(1,i);
            p2 = m.C(j + 1,i);
        end
        if j>=3
%            p1 = m.C(i,4);
%            p2 = m.C(i,j - 1); 
            p1 = m.C(4,i);
            p2 = m.C(j - 1, i);
        end
        minIndex = min(p1, p2);
        maxIndex = max(p1, p2);
        k = find(E(:,minIndex) == maxIndex);
        if isempty(k)
            E(filledEntries(minIndex), minIndex) = maxIndex;
            filledEntries(minIndex) = filledEntries(minIndex) + 1;
        else
            I(k, minIndex) = 1;
        end
        
        
    end
end
K = filledEntries - 1;
n = size(E,1) - size(I,1);
if n>0
   I = [I;zeros(n,size(I,2))];
end
