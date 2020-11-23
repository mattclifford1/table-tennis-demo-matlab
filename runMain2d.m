%close all

%calcuating first trajectory until bounce            |pos|    |vel|    |w|
[posB,velBB,omegaBB,path1] = trajectory([0,0,0.1],[12,0,5],[0,314,0]);
%velocity and angular velocity change after the bounce
[velAB,omegaAB] = bounce(velBB,omegaBB);
%calculating second trajectory until bounce
[posB,velBB,omegaBB,path2] = trajectory(posB,velAB,omegaAB);

%concatinating both trajectories
path = [path1;path2];
path = path1;

t=length(path); stop = []; frames = 10;
for i = 1:frames
    stop = round([stop ((t*i)/frames)]);
end
%stop frame animation
for i = stop%1:length(path)
    %hold off
    plot(path(:,1),path(:,3),'r','LineWidth',1.1)
    hold on
    plot([0,2.74],[0 0],'b','LineWidth',2)
    plot([1.37,1.37],[0,0.15],'b','LineWidth',2) 
    grid on
    axis equal
    plot(path(i,1),path(i,3),'ko')
    pause(0.01) %same as time step in ode45, so gives real time animation
    xlabel('x');ylabel('z')
end

    
    