
%m/s
topSpeed38 = 31.2; regular38 = 24.59;
%kilograms
mass38 = 0.0025; mass40 = 0.0027;
%calculating moment of inertia for each ball
inertia38 = inertiaBall1_1(38,mass38);
inertia40 = inertiaBall1_1(40,mass40);

%from 1/2*m*v^2 , ke in KJoules if kilos used
keSmashTop = 0.5*mass38*(topSpeed38^2)
topSpeed40 = ((2*keSmashTop)/mass40)^0.5;

keSmashReg = 0.5*mass38*(regular38^2);
regular40 = ((2*keSmashReg)/mass40)^0.5;

%from 1/2*Io*w^2, angluar velocity in rad/s
keSpin=0.5*inertia38*(150*2*pi)^2
spinPercent = keSpin/keSmashTop

%answer converted to rps
omega38 = (sqrt((2*keSpin)/inertia38))/(2*pi)
omega40 = (((2*keSpin)/inertia40)^0.5)/(2*pi)

%omega38/omega40




