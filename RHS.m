function [out1, out2, out3] = RHS(t,state,options,P)

global lengthT; global width; 

%nice variable names
x=state(1);y=state(2);z=state(3);
vx=state(4);vy=state(5);vz=state(6);
omegax=state(7);omegay=state(8);omegaz=state(9);

%the speed
absv=sqrt(vx^2+vy^2+vz^2);

%stop condition when ball hits the surface 
stop = 1;
%for table
if state(3) < 0.02 && state(1) < ((lengthT) +0.095) && abs(state(2)) < width/2 %takes into account the radius of the ball
    pos=[state(1);state(2);state(3)];
    vel=[state(4);state(5);state(6)];
    angvel=[state(7);state(8);state(9);];
    stop = 0;
end
%for floor
if state(3) < -0.72
    pos=[state(1);state(2);state(3)];
    vel=[state(4);state(5);state(6)];
    angvel=[state(7);state(8);state(9);];
    stop = 0; 
end
if nargin < 3 | isempty(options)
%Right hand side of the vector field
out1 = [vx; vy; vz;...
    -P.Kd*vx*absv+P.Km*(-omegay*vz+vy*omegaz);...
    -P.Kd*vy*absv+P.Km*(-omegax*vz+vx*omegaz);...
    -P.g-P.Kd*vz*absv-P.Km*(-omegax*vy+vx*omegay);...
    P.alpha*omegax*vx; P.alpha*omegay*vy; P.alpha*omegaz*vz;];
else
    switch(options)
        case 'events'       % used only if 'Events' is 'on'
            out1 = stop;    % Detect height = 0
            out2 = 1;       % Stop the integration
            out3 = -1;      % Negative direction only, namely decreasing through z=0
    end
end
end