function plot3d(path,X,Y,Z,X2,Y2,Z2,X3,Y3,Z3)
global lengthT; global width; global stepTime;
%making real size ball
r=0.02;
phi=linspace(0,pi,30);
theta=linspace(0,2*pi,40);
[phi,theta]=meshgrid(phi,theta);
x=r*sin(phi).*cos(theta);
y=r*sin(phi).*sin(theta);
z=r*cos(phi);

err=0.2;
[minX maxX minY maxY] = getLim(path,lengthT,width,err);
%stop motion animation
for i = 1:length(path)
    hold off
    plot3(path(:,1),path(:,2),path(:,3),'r');
    hold on
    %plotting table surface
    plotTable(lengthT,width,0.1)
    grid on
    axis equal
    a=path(i,1);b=path(i,2);c=path(i,3);
    surf(x+a, y+b, z+c)
    %plot angular velocity and spin
    plot3([path(i,1) X(i)],[path(i,2) Y(i)],[path(i,3) Z(i)],'g','LineWidth',2)
    plot3([path(i,1) X2(i)],[path(i,2) Y2(i)],[path(i,3) Z2(i)],'r','LineWidth',2)
    plot3([path(i,1) X3(i)],[path(i,2) Y3(i)],[path(i,3) Z3(i)],'r','LineWidth',2)
    %set axis scale
    set(gca,'DataAspectRatio',[1 1 1],...
        'PlotBoxAspectRatio',[1 1 1],...
        'XLim',[minX maxX],...
        'YLim',[minY maxY],...
        'ZLim',[-0.74 (max(path(:,3))+err)])
    pause(stepTime) %same as time step in ode45, so gives real time animation
    xlabel('x');ylabel('y');zlabel('z');
end