function rps =  spin(diam,mass,ke)

inertia = inertiaBall1_1(diam,mass);
rps = (sqrt((2*ke)/inertia))/(2*pi);