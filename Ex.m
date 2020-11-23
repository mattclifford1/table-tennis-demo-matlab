

r= 0.02; v1=27; v2 =25; w1 = 130;
% eX = -(v2 - r*w2)/(v1 - r*w1);
eX = linspace(-1,1);

w2 = (-r*w1*eX + eX*v1 + v2)/r;

plot(eX,w2)
