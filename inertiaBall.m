function [inertia]= inertiaBall(radius,thickness,mass)
%calculate moment of intertia of a shell (ball)
%radius and thickness are in mm
%mass in grams

%changing to S.I.
radius = radius/1000; thickness = thickness/1000;
%calculating parameters
r2=radius; r1=radius-thickness;
%moment of inertia equation - derived from triple integral
inertia=(2*mass/5)*((r2^5 - r1^5)/(r2^3 - r1^3));

% density = 1375;
% Volume=mass/density;
% r1 = (r2^3 - (Volume/(4*pi/3)))^(1/3);
% thick = (r2-r1);
% inertia2=(2*mass/5)*((r2^5 - r1^5)/(r2^3 - r1^3));