function runMain3d(posX,posY,posZ,velX,velY,velZ,wX,wY,wZ)

global lengthT; global width; global stepTime;
lengthT = 2.7; width = 1.52;
%converting to radians per second
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
if (max(max(omegaPath))) ~= 0
    omegaPathN = omegaPath/(4*(max(max(omegaPath))));
else
    omegaPathN = omegaPath;
end
%working out angular velocity vectors
X = path(:,1) + omegaPathN(:,1);
Y = path(:,2) + omegaPathN(:,2);
Z = path(:,3) + omegaPathN(:,3);

%initialising vectors for for loop
vec1 = zeros(length(path)+1,3); vec2 = zeros(length(path)+1,3);
%rotate orthogonal vectors by how much the ball has spun
for i = 1:length(path)
    if sum(omegaPathN(1,:)) ~= 0 && i == 1 
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

%animate
plot3d(path,X,Y,Z,X2,Y2,Z2,X3,Y3,Z3)