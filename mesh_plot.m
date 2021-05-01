function mesh_plot(m, subdiv)
n = 2^subdiv;
for i = 1:size(m.C,2)
    f = m.M{i};
    for j = 1:4
%         p1 = m.V(:,m.C(j,i));
%         p2 = m.V(:,m.C(mod(j,4) + 1,i));
        if j<3
            p1 = m.V(:,1);
            p2 = m.V(:,j + 1);
        end
        if j>=3
           p1 = m.V(:,4);
           p2 = m.V(:,j - 1); 
        end
        v = p2 - p1;
        seg = zeros(2,n+1);
        for t = 0:n
            p = p1 + t/n*v;
            seg(:,t+1) = f(p(1),p(2));
        end
        for t = 1:n
            po1 = seg(:,t);
            po2 = seg(:,t+1);
            plot([po1(1),po2(1)],[po1(2),po2(2)], 'k');
            hold on
        end
        if m.B(m.C(j,i)) == 2
            po1 = m.V(:,j);
            po1 = f(po1(1),po1(2));
            scatter(po1(1), po1(2), 'o', 'r')
        end
        if m.B(m.C(j,i)) == 0
            po1 = m.V(:,j);
            po1 = f(po1(1),po1(2));
            scatter(po1(1), po1(2), '*', 'r')
%             scatter(seg(1,1), seg(2,1), '*', 'r')
        end
        
    end
end
% 





% for i = 1:length(m.B)
%    if m.B(i) == 2
%        scatter(mesh.P(1,i), mesh.P(2,i), 'o', 'r')
%    end
%    if mesh.B(i) == 0
%        scatter(mesh.P(1,i), mesh.P(2,i), '*', 'r')
%    end
% end