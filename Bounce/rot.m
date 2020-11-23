function vecA = rot(omega,vecB,theta)
%rotates about unit vector in 3d
u = omega/norm(omega);
uX = u(1); uY = u(2); uZ = u(3);
%rotation matrix
R = [cos(theta)+(uX^2)*(1-cos(theta)),uX*uY*(1-cos(theta))-uZ*sin(theta),...
    uX*uZ*(1-cos(theta))+uY*sin(theta);
    uX*uY*(1-cos(theta))+uZ*sin(theta),cos(theta)+(uY^2)*(1-cos(theta)),...
    uY*uZ*(1-cos(theta))-uX*sin(theta);
    uX*uZ*(1-cos(theta))-uY*sin(theta),uY*uZ*(1-cos(theta))+uX*sin(theta),...
    cos(theta)+(uZ^2)*(1-cos(theta))];
%times together
vecA = [R(1,1)*vecB(1) + R(1,2)*vecB(2) + R(1,3)*vecB(3),...
    R(2,1)*vecB(1) + R(2,2)*vecB(2) + R(2,3)*vecB(3),...
    R(3,1)*vecB(1) + R(3,2)*vecB(2) + R(3,3)*vecB(3)];
%normalise
vecA = vecA/norm(vecA);
