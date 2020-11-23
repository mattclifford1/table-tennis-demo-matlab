function rps =  spin2(diam,mass,ke,thickness)

inertia = inertiaBall2(diam,thickness,mass);
rps = (sqrt((2*ke)/inertia))/(2*pi);