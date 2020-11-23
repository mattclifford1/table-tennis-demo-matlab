function [posOut,velOut,omegaOut,path,omegaPath,contact] = trajectory(posIn,velIn,omegaIn)
%INPUTS:  posIn    - starting position (m), 3 X 1 vector
%         velIn    - starting velocity(m/s), 3 X 1 vector
%         omegaIn  - starting angular velocity(revolutions/s), 3 X 1 vector

%setting coefficients
%Diameter of ball in meters
D=0.04;
R=D/2;
a=pi*R^2;
%Drag coefficient estimate
CDrag=0.4;
%Magnus coefficient estimate
CMagnus=1;
%density of the air kg/m^3
rhoAir=1.29;

%Ping-pong ball mass in kg
P.m=0.0027;
P.g=9.8015;  %acc due to gravity m/s^2
%degradation rate of spin - set to zero for no degradation
deg = 1;
% P.alphax=deg;
% P.alphay=deg;
% P.alphaz=deg;

I = inertiaB(R,0.0027);

P.alpha=(-R*rhoAir*a*R*0.012)/I;

%Force coefficients, drag and Magnus
P.Kd=CDrag*rhoAir*pi*D^2/(8*P.m);
P.Km=CMagnus*rhoAir*pi*D^3/(8*P.m);

%Rules for bouncing
P.restitution=0.7;  % coefficient of restitution; '1' for a perfect bounce
%--------------------------------------------------------------------------

%initial position
x0=posIn(1);y0=posIn(2);z0=posIn(3);
%initial velocity
vx0=velIn(1);vy0=velIn(2);vz0=velIn(3);
%initial angular velocity
omegax0=omegaIn(1);omegay0=omegaIn(2);omegaz0=omegaIn(3);

%initial conditions
X0=[x0;y0;z0;vx0;vy0;vz0;omegax0;omegay0;omegaz0];
tstart=0;
tfinal=2;  %in sec
global stepTime; stepTime = 0.03;

options1=odeset('events', 'on', 'RelTol', 1e-7, 'AbsTol', 1e-8);

[tt,state,te,oute,ie] = ode45('RHS', [tstart:stepTime:tfinal],X0,options1,P);

%encoding bounce data for output
if isempty(oute) == 1
    posOut = [state(end,1);state(end,2);state(end,3)];
    velOut = [state(end,4);state(end,5);state(end,6)];
    omegaOut = [state(end,7);state(end,8);state(end,9)];
else
    posOut = [oute(1);oute(2);oute(3)];
    velOut = [oute(4);oute(5);oute(6)];
    omegaOut = [oute(7);oute(8);oute(9)];
end
contact = 0;
if isempty(oute) == 0
    if oute(3) > 0
        contact = 1;
    end
end
%encoding trajectory data for output
path = [state(:,1),state(:,2),state(:,3)];
omegaPath = [state(:,7),state(:,8),state(:,9)];
end