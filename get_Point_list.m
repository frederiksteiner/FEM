function P = get_Point_list(m)
numOfnodes = max(m.C(:));
I = zeros(numOfnodes,1);
dim = size(m.M{1}(1,1),1);
P = zeros(dim,numOfnodes);
for i = 1:size(m.C,2)
    f = m.M{m.P(i)};
    stk = m.R(:,m.K(i));
    for j = 1:4
        if I(m.C(j,i)) == 0
            I(m.C(j,i)) = 1;
            p1 = m.V(:,stk(j));
            P(:,m.C(j,i)) = f(p1(1),p1(2));
        end
        
    end
end