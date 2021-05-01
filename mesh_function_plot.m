function mesh_function_plot(f, m)
 P = get_Point_list(m);
%  if size(P, 1) == 2
%      P = [P, zeros(1, size(P, 2))];
%  end
 vert = [P',f];
% vert = P';
 C = [m.C(1,:);m.C(2,:);m.C(4,:);m.C(3,:)];
 fac = C';
 patch('Faces',fac,'Vertices',vert,'FaceVertexCData',f/norm(f),'FaceColor','flat','Edgecolor','none');
%  view(3);