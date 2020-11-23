function rps =  spin3(diam,ke,thickness)

inertia = inertiaBall1_2(diam,thickness);
rps = (sqrt((2*ke)/inertia))/(2*pi);