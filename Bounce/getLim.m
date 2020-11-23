function[minX maxX minY maxY] = getLim(path,lengthT,width,err)

if abs(min(path(:,2))) > (width/2)
    minY = min(path(:,2)) - err;
else
    minY = -((width/2) + err);
end
if abs(max(path(:,2))) > (width/2)
    maxY = max(path(:,2)) + err;
else
    maxY = (width/2) + err;
end

if abs(min(path(:,1))) > (0)
    minX = min(path(:,1)) - err;
else
    minX = -(0 + err);
end
if abs(max(path(:,1))) > (lengthT)
    maxX = max(path(:,1)) + err;
else
    maxX = (lengthT) + err;
end