function Bat(velB,omegaB,velP,phiP)

z=[0 0 1];

xB = velB(1); zB = velB(3);
% thetaB = atan(yB/xB);
xP = velP(1); zP = velP(3); 
% thetaP = atan(yP/xP);
moB = sqrt(xB^2+zB^2); moP=sqrt(xP^2+zP^2);
v_ix = velB(1);v_iy = velB(2);v_iz = velB(3);
v_pix = velP(1);v_piy = velP(2);v_piz = velP(3);
w_ix = omegaB(1);w_iy = omegaB(2);w_iz = omegaB(3);

g = (dot(velB,z))/(moB*moP);
g = acos(g);
g = pi - g - phiP;
a = pi/2 - g;

theta = (dot(velP,z))/(moB*moP);
theta = acos(theta);
theta = phiP - theta;

v_in = velP*sin(theta) - velB*cos(a);

mu = 0.6; kv = 0.7;r=0.02;

D = sqrt(((v_iy-v_piy)-w_iz*r)^2 + ((v_iz-v_piz)+w_iy*r)^2);

N = mu*(1+kv)*norm(v_in);

v_ex = ((N*((w_iy*r)-v_ix+v_pix))/D)+(+v_ix-v_pix)
v_ez = ((N*((w_ix*r)-v_iy+v_piy))/D)+(v_iy-v_piy)

w_ey = w_iy + 3*mu*(1+kv*norm(v_in)*(-w_iy*r-v_iz+v_piz))/(2*r) %(3*N*(-w_ix*r-v_iy+v_piy))/(2*r*D)
w_ez = w_iz - 3*mu*(1+kv)*norm(v_in)*(w_iz*r-v_iy+v_piy)/(2*r) %  (3*N*(-w_iy*r-v_ix+v_pix))/(2*r*D)
