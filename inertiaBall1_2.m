function [inertia]= inertiaBall1_2(diam,thickness)
% calculate moment of intertia of a shell (ball)
% radius and thickness are in mm
% mass in grams

% changing to S.I.
radius = diam/2000; thickness = thickness/1000; 
% calculating parameters
r2=radius;
r1=radius-thickness;
density = 1375;
Volume = ((4*pi)/3)*(r2^3 - r1^3);
mass = Volume*density;
% moment of inertia equation - derived from triple integral
inertia=(2*mass/5)*((r2^5 - r1^5)/(r2^3 - r1^3));
