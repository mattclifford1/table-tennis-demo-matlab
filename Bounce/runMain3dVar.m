function runMain3dVar(posX,posY,posZ,velX,velY,velZ,wX,wY,wZ)
close all
%clear all;
%useage runMain3dVar(0,0,0.1,5,0,2,0,0,50)
global lengthT; global width; global stepTime;
lengthT = 2.7; width = 1.52;
%converting to radians per second
wX=wX*2*pi; wY=wY*2*pi; wZ=wZ*2*pi;
%--------------------------------------------------------------------------
%model calculations
%calcuating first trajectory until bounce                    |pos|    |vel|    |w|
count = 1; rho = (linspace(1,1.6,4)); %Y=zeros(lenght(rho),1);
% plotTable(lengthT,width,0.1)
for i = rho
    [posB,velBB,omegaBB,path1,omegaPath1,contact] = trajectoryVar([posX,posY,posZ],[velX,velY,velZ],[wX,wY,wZ],i);
    Y(count) = posB(2);
    count = count +1;
    hold on
    y = omegaPath1/(2*pi);
    plot3(path1(:,1),path1(:,2),path1(:,3),'LineWidth',1.1);
%     figure(1)
%     plot(linspace(0,1),y(1:100,2))
%     
%     figure(2)
%     plot(linspace(0,1),y(1:100,2))
%     figure(3)
%     plot(linspace(0,1),y(1:100,3))
end
% title('Change in x/y angular velocity')
% legend('rho = 1','rho = 1.2','rho = 1.4','rho = 1.6')
% xlabel('time');ylabel('spin - revolutions per second');
grid on;% axis equal;
xlabel('x');ylabel('y');zlabel('z');
a=max(path1(:,1));b = max(abs(path1(:,2))); c=0;
vertic = [0 0 -c;a 0 -c;a b -c;0 b -c;0 0 0;a 0 0;a b 0;0 b 0]; 
face = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
% patch('Vertices',vertic,'Faces',face,'FaceVertexCData',[0.9 0.9 0.9],'FaceColor','flat')

% figure
% plot(rho,Y,'LineWidth',2)
% xlabel('Air density');ylabel('Y displacement at bounce');
% % if contact == 1
% %     %velocity and angular velocity change after the bounce
% %     [velAB,omegaAB] = bounce(velBB,omegaBB);
% %     %calculating second trajectory until bounce
% %     [posB,velBB,omegaBB,path2,omegaPath2] = trajectory(posB,velAB,omegaAB);
% % end
%--------------------------------------------------------------------------


% % contact = 0;
% % %concatinating both trajectories
% % if contact == 1
% %     path = [path1;path2]; omegaPath = [omegaPath1;omegaPath2];
% % else
% %     path = path1; omegaPath = omegaPath1;
% % end
% % %scaling angular velocity, for nice plotting
% % if (max(max(omegaPath))) ~= 0
% %     omegaPathN = omegaPath/(4*(max(max(omegaPath))));
% % else
% %     omegaPathN = omegaPath;
% % end
% % %working out angular velocity vectors
% % X = path(:,1) + omegaPathN(:,1);
% % Y = path(:,2) + omegaPathN(:,2);
% % Z = path(:,3) + omegaPathN(:,3);
% % 
% % %initialising vectors for for loop
% % vec1 = zeros(length(path)+1,3); vec2 = zeros(length(path)+1,3);
% % %rotate orthogonal vectors by how much the ball has spun
% % for i = 1:length(path)
% %     if sum(omegaPathN(1,:)) ~= 0 && i == 1 %(length(path1))
% %         %find orthogonal vectors to angular velocity
% %         [a1 a2] = (findOrth(omegaPathN(i,:)));
% %         a1=a1'; a2=a2';
% %         vec1(i,:) = a1; vec2(i,:) = a2;
% %     end
% %     if sum(omegaPathN(1,:)) == 0 && i == (length(path1)+1)
% %         %find orthogonal vectors to angular velocity
% %         [a1 a2] = (findOrth(omegaPathN(i,:)));
% %         a1=a1'; a2=a2';
% %         vec1(i,:) = a1; vec2(i,:) = a2;
% %     end
% %     theta = sum(omegaPath(i,:))*stepTime;
% %     vec1(i+1,:) = rot(omegaPath(i,:),vec1(i,:),theta);
% %     vec2(i+1,:) = rot(omegaPath(i,:),vec2(i,:),theta);
% % end
% % 
% % %scale down to nice plotting
% % scale = 10; vec1 = vec1/scale; vec2 = vec2/scale;
% % 
% % %translate vectors to be in the ball's frame of reference
% % X2 = path(:,1) + vec1([1:length(path)],1);
% % Y2 = path(:,2) + vec1([1:length(path)],2);
% % Z2 = path(:,3) + vec1([1:length(path)],3);
% % 
% % X3 = path(:,1) + vec2([1:length(path)],1);
% % Y3 = path(:,2) + vec2([1:length(path)],2);
% % Z3 = path(:,3) + vec2([1:length(path)],3);
% % 
% % %animate
% % plot3d(path,X,Y,Z,X2,Y2,Z2,X3,Y3,Z3)