function [inertia]= inertiaB(r2,mass)
% calculate moment of intertia of a shell (ball)
% mass in kilograms
 
% calculating parameters
density = 1375;
Volume=mass/density;
r1 = (r2^3 - (Volume/(4*pi/3)))^(1/3);
% moment of inertia equation - derived from triple integral
inertia=(2*mass/5)*((r2^5 - r1^5)/(r2^3 - r1^3));