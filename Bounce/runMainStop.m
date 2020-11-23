function runMainStop(posX,posY,posZ,velX,velY,velZ,wX,wY,wZ,frames)
global lengthT; global width; global stepTime;
lengthT = 2.7; width = 1.52;
wX=wX*2*pi; wY=wY*2*pi; wZ=wZ*2*pi;
%--------------------------------------------------------------------------
%model calculations
contact = 0; contact2 = 0; countB = 0;
%calcuating first trajectory until bounce                   
[posB,velBB,omegaBB,path1,omegaPath1,contact] = trajectory([posX,posY,posZ],[velX,velY,velZ],[wX,wY,wZ]);
path = path1; omegaPath = omegaPath1;
%carry on bouncing until off the table
while contact == 1 && countB < 4
    %velocity and angular velocity change after the bounce
    [velAB,omegaAB] = bounce(velBB,omegaBB);
    %calculating second trajectory until bounce
    [posB,velBB,omegaBB,path1,omegaPath1,contact] = trajectory(posB,velAB,omegaAB);
    %concatinating both trajectories
    path = [path;path1]; omegaPath = [omegaPath;omegaPath1];
    countB = countB + 1;
end
%--------------------------------------------------------------------------
%scaling angular velocity, for nice plotting
if (max(max(omegaPath))) ~= 0
    omegaPathN = omegaPath/(4*(max(max(omegaPath))));
else
    omegaPathN = omegaPath;
end
%working out angular velocity vectors
X = path(:,1) + omegaPathN(:,1);
Y = path(:,2) + omegaPathN(:,2);
Z = path(:,3) + omegaPathN(:,3);
%making equal spaced plot points in time
t=length(path); stop = [];
for i = 1:frames
    stop = round([stop ((t*i)/frames)]);
end
%initialising vectors for for loop
vec1 = zeros(length(path)+1,3); vec2 = zeros(length(path)+1,3);
%rotate orthogonal vectors by how much the ball has spun
for i = 1:length(path)
    if sum(omegaPathN(1,:)) ~= 0 && i == 1 %(length(path1))
        %find orthogonal vectors to angular velocity
        [a1 a2] = (findOrth(omegaPathN(i,:)));
        a1=a1'; a2=a2';
        vec1(i,:) = a1; vec2(i,:) = a2;
    end
    if sum(omegaPathN(1,:)) == 0 && i == (length(path1)+1)
        %find orthogonal vectors to angular velocity
        [a1 a2] = (findOrth(omegaPathN(i,:)));
        a1=a1'; a2=a2';
        vec1(i,:) = a1; vec2(i,:) = a2;
    end
    theta = sum(omegaPath(i,:))*stepTime;
    vec1(i+1,:) = rot(omegaPath(i,:),vec1(i,:),theta);
    vec2(i+1,:) = rot(omegaPath(i,:),vec2(i,:),theta);
end

%scale down to nice plotting
scale = 10; vec1 = vec1/scale; vec2 = vec2/scale;

%translate vectors to be in the ball's frame of reference
X2 = path(:,1) + vec1([1:length(path)],1);
Y2 = path(:,2) + vec1([1:length(path)],2);
Z2 = path(:,3) + vec1([1:length(path)],3);

X3 = path(:,1) + vec2([1:length(path)],1);
Y3 = path(:,2) + vec2([1:length(path)],2);
Z3 = path(:,3) + vec2([1:length(path)],3);

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

%plotting specified points in time
hold off
for i = stop
    plot3(path(:,1),path(:,2),path(:,3),'k');
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