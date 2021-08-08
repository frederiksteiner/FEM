# FEM
Finite Element Method project done for lecture: Numerik der partiellen Differentialgleichungen
Here the domain was discretized with the help of squares instead of triangles. In the end, we solved the Gray Scott model which describes a particular chemical process
Description of the most important functions, see below:

-__function m = mesh_refine(m)__: refines mesh m

-__function mesh_plot(m, subdiv)__: function used to plot the mesh m

-__function [A, M] = matrices_assemble(m)__: assembles the mass and stiffness matrix corresponding to the underlying problem

-__function g = compute_nodal_interpolation(gf, m)__: interpolates function gf onto the gridpoints of the mesh

-__function [uh, vh, ts, gs] = gray_scott(a, b, c, d, e, f, m, u0f, v0f, dt, T)__: calculates and visualizes gray scott model

For more in-depth project description in german, see also: http://cm.dmi.unibas.ch/teaching/npde/projekt.pdf





