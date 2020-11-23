function [velOut, omegaOut] = bounce(velIn,omegaIn)
%function that takes the velocity and angular velocity just before the ball
%bounces, and outputs the velocity and angular velocity after the ball
%exits the bounce.
%INPUTS:  velIn    - starting velocity(m/s), 3 X 1 vector        
%         omegaIn  - starting angular velocity(revolutions/s), 3 X 1 vector

eq = 1; %choose which formula to use
%setting constants
%coefficient of restitution
k=0.7; 
%coefficient of friction
mu=0.4; 
%radius of ball
r=0.02;

%converting rps to radians per second
omegaIn = omegaIn*2*pi;
%extracting input data
v_ix = velIn(1); v_iy = velIn(2); v_iz = velIn(3);
w_ix = omegaIn(1); w_iy = omegaIn(2); w_iz = omegaIn(3); 

if eq == 1
    %velocity change equations
    v_ex = 0.4*w_iy*r + 0.6*v_ix;
    v_ey = -0.4*w_ix*r + 0.6*v_iy;
end
if eq == 2
    r1 = 1.96; r2 = 0.02;
    a = ((r2^5-r1^5)/(r2^3-r1^3));
%     N = (2*(r2^5 - r1^5))/((2*(r2^5 - r1^5))+(5*(r2^3 - r1^3)));
    N = a/(a+((5/2)*r2));
    %velocity change equations
    v_ex = (1 - N)*v_ix + N*w_iy*r2;
    v_ey = (1 - N)*v_iy - N*w_ix*r2;
end
%velocity change z equation
v_ez = -k*v_iz;
%angular velocity change equations
w_ex = 0.4*w_ix - (0.6*v_iy)/r;
w_ey = 0.4*w_iy + (0.6*v_ix)/r;
w_ez = w_iz;

%encoding data for output
velOut = [v_ex; v_ey; v_ez];
omegaOut = [w_ex; w_ey; w_ez];
%converting back to rps
omegaOut = omegaOut/(2*pi);