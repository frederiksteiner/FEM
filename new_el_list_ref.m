function RR = new_el_list_ref(R, E, L, midPInd)
RR = zeros(4, 4*size(R,2));
m = zeros(4,1);
for i = 1:size(R,2)
    for j=1:4
        if j<3
            minIndex = min(R(1,i), R(j+1,i));
            maxIndex = max(R(1,i), R(j+1,i));
        else
            minIndex = min(R(4,i), R(j-1,i));
            maxIndex = max(R(4,i), R(j-1,i));
        end
        k = find(E(:,minIndex) == maxIndex);
        m(j) = L(k,minIndex);
    end
    RR(:,(4*i-3):4*i) = [R(1,i), m(1), m(2), midPInd(:,i);...
                         m(1), R(2,i), midPInd(:,i), m(3);...
                         m(2), midPInd(:,i), R(3,i), m(4);...
                         midPInd(:,i), m(3), m(4),R(4,i)];
end
    