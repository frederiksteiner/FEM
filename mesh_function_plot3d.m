function mesh_function_plot3d(f, m)
 P = get_Point_list(m);
 dim = size(P, 1);
 if dim == 2
     P = [P; zeros(1, size(P, 2))];
 end
%  vert = [P',f];
vert = P';
 C = [m.C(1,:);m.C(2,:);m.C(4,:);m.C(3,:)];
 fac = C';
 patch('Faces',fac,'Vertices',vert,'FaceVertexCData',f/norm(f),'FaceColor','flat','Edgecolor','none');
 if dim ~=2
    view(3);
 end