function [E,K,I] = edge_list_ref(R, numP)
E = zeros(4, numP);
I = zeros(size(E));
filledEntries = ones(numP,1);
for i = 1:size(R,2)
    for j= 1:4
        if j<3
%             p1 = m.C(i,1);
%             p2 = m.C(i,j + 1);
            p1 = R(1,i);
            p2 = R(j + 1,i);
        end
        if j>=3
%            p1 = m.C(i,4);
%            p2 = m.C(i,j - 1); 
            p1 = R(4,i);
            p2 = R(j - 1, i);
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