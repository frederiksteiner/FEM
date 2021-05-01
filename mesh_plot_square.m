function mesh_plot_square(V, R)
n = size(R);
n = n(2);
for i = 1:n
    
%     for j = 1:4
%         p1 = V(:,R(j,i));
%         p2 = V(:,R(mod(j,3) + 1,i));
%         plot([p1(1),p2(1)],[p1(2),p2(2)], 'k');
%         hold on
%     end
    for j = 1:4
        if j<3
            p1 = V(:,R(1,i));
            p2 = V(:,R(j + 1,i));
        
        else 
           p1 = V(:,R(4,i));
           p2 = V(:,R(j - 1,i)); 
        end
        plot([p1(1),p2(1)],[p1(2),p2(2)], 'k');
        hold on
    end
end

% for i = 1:length(mesh.P)
%    if mesh.B(i) == 2
%        scatter(mesh.P(1,i), mesh.P(2,i), 'o', 'r')
%    end
%    if mesh.B(i) == 0
%        scatter(mesh.P(1,i), mesh.P(2,i), '*', 'r')
%    end
% end