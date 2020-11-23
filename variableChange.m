close all
diam = 40; ke = 0.2615; mass = 0.0027;
mass1 = linspace(2,4);
diam1 = linspace(20,60); 
thickness = linspace(0.1,1);
for i = linspace(1,100)
    rpsMass(i) = spin(diam,(mass1(i)/1000),ke);
    rpsDiam(i) = spin(diam1(i),mass,ke);
    rpsThick(i) = spin2(diam,mass,ke,thickness(i));
    rpsThick2(i) = spin3(diam,ke,thickness(i));
end
% subplot(2,2,1);
figure
plot(mass1,rpsMass,'LineWidth',1.5); xlabel('mass - grams');ylabel('Revolutions per second')
title('Fixed energy and diamter, with varying ball mass')
% subplot(2,2,2);
plot(diam1,rpsDiam,'LineWidth',1.5); xlabel('ball diameter - mm');ylabel('Revolutions per second')
title('Fixed energy and mass, with varying ball diameter')
% subplot(2,2,3);
figure
plot(thickness,rpsThick,'LineWidth',1.5); xlabel('ball thickness - mm');ylabel('Revolutions per second')
title('Fixed energy, mass and diamter, with varying ball thickness')
% subplot(2,2,4);
figure
plot(thickness,rpsThick2,'LineWidth',1.5); xlabel('ball thickness - mm');ylabel('Revolutions per second')
title('Fixed energy and diamter, with varying ball thickness and mass')

