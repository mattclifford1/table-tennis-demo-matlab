function plotTable(a,b,c)
%a = length
%b = width
%c = hieght

% plotting table
vertic = [0 -b/2 -c;a -b/2 -c;a b/2 -c;0 b/2 -c;0 -b/2 0;a -b/2 0;a b/2 0;0 b/2 0]; 
face = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
patch('Vertices',vertic,'Faces',face,'FaceVertexCData',[0 0.5 0.9],'FaceColor','flat')

lin = 0.01;
vertic = [0 -lin -c;a -lin -c;a lin -c;0 lin -c;0 -lin 0;a -lin 0;a lin 0;0 lin 0]; 
face = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
patch('Vertices',vertic,'Faces',face,'FaceVertexCData',[1 1 1],'FaceColor','flat')

% plotting net
w = 0.025; h = 0.1525; l = 0.05;
verticN = [a/2-w -b/2-l 0;a/2+w -b/2-l 0;a/2+w b/2+l 0;a/2-w b/2+l 0;...
    a/2-w -b/2-l h;a/2+w -b/2-l h;a/2+w b/2+l h;a/2-w b/2+l h]; 
faceN = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
patch('Vertices',verticN,'Faces',faceN,'FaceVertexCData',[0 0 0.9],'FaceColor','flat')

% plotting legs
w2=0.02; f=-0.74; leg = 3;
for i = [-1 1]
    for j = [1 3]
        verticN = [j*a/4-w2 i*b/leg-w2 f;j*a/4+w2 i*b/leg-w2 f;j*a/4+w2 i*b/leg+w2 f;j*a/4-w2 i*b/leg+w2 f;...
            j*a/4-w2 i*b/leg-w2 -c;j*a/4+w2 i*b/leg-w2 -c;j*a/4+w2 i*b/leg+w2 -c;j*a/4-w2 i*b/leg+w2 -c];
        faceN = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
        patch('Vertices',verticN,'Faces',faceN,'FaceVertexCData',[0 0 0],'FaceColor','flat')
    end
end


    