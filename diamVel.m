

diam = 30:1:50; count = 1; rps=150;
for i = diam
   vel(count) = batSpeed(i,rps);
   rps(count) = spin(i,2.5,0.25);
   count = count +1;
end
 plot(diam,vel); xlabel('Ball Diameter - mm');ylabel('Bat Velocity - m/s')

figure
plot(diam,rps)
