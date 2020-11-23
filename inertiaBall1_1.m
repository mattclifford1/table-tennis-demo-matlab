function [inertia]= inertiaBall1_1(diam,mass)
% calculate moment of intertia of a shell (ball)
% radius and thickness are in mm
% mass in kilograms

% changing to S.I.
r2 = diam/2000; %thickness = thickness/1000; 
% calculating parameters
density = 1375;
Volume=mass/density;
r1 = (r2^3 - (Volume/(4*pi/3)))^(1/3);
 thick = (r2-r1);
% moment of inertia equation - derived from triple integral
inertia=(2*mass/5)*((r2^5 - r1^5)/(r2^3 - r1^3));

i2 = (2*mass*r2^2)/3;
diff  = inertia - i2;

diff/i2
