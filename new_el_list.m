function [VV,PP,KK] = new_el_list(V, E, L, midPInd, P,refLevel)
% FF = zeros(3, 4*length(F));
% for i = 1:length(F)
%     for j=1:3
%         minIndex = min(F(j,i), F(mod(j,3)+1,i));
%         maxIndex = max(F(j,i), F(mod(j,3)+1,i));
%         k = find(E(:,minIndex) == maxIndex);
%         m(j) = L(k,minIndex);
%     end
%     FF(:,(4*i-3):4*i) = [F(1,i), m(1), m(3), m(2); m(1), F(2,i), m(2), m(3); m(3), m(2), F(3,i), m(1)];
% end
VV = zeros(4, 4*size(V,2));
PP = zeros(1, 4*size(V,2));
KK = zeros(1, 4*size(V,2));
m = zeros(4,1);
for i = 1:size(V,2)
    
    for j=1:4
        if j<3
            minIndex = min(V(1,i), V(j+1,i));
            maxIndex = max(V(1,i), V(j+1,i));
        else
            minIndex = min(V(4,i), V(j-1,i));
            maxIndex = max(V(4,i), V(j-1,i));
        end
        k = find(E(:,minIndex) == maxIndex);
        m(j) = L(k,minIndex);
    end
    VV(:,(4*i-3):4*i) = [V(1,i), m(1), m(2), midPInd(:,i);...
                         m(1), V(2,i), midPInd(:,i), m(3);...
                         m(2), midPInd(:,i), V(3,i), m(4);...
                         midPInd(:,i), m(3), m(4),V(4,i)];
                     
    PP(:,(4*i-3):4*i) = P(i)*ones(4,1);
%     KK(:,(4*i-3):4*i) = [1,2,3,4]; 
    KK(:, (4*i-3):4*i) = mod((4*i-4):(4*i-1), 4^(refLevel+1)) + 1; %aufpassen hier, nicht allgemein
end
    