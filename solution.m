cd '/Users/johnwilhoite/Documents/MATLAB/Transport'
clear all 

%%%%  CALIBRATION  %%%%
a = zeros(3,1);
a(1) = 1; %productivity of region 1 commodity sector
a(2) = 1; %productivity of region 2 commodity sector
a(3) = 1; %productivity of transport sector

d=zeros(4,1);
d(1) = 1; %d_11, region 1 to 1 required transport services
d(2) = 1.5; %d_12, region 1 to 2 required transport services
d(3) = 1; %d_22
d(4) = 1.5; %d_21
t = 1;

gamma = 0.75; 

%%%% Solving the Model  %%%%
fun = @(x) model(x,gamma, a, d, t);
x0 = ones(1,21);

x = fsolve(fun,x0); 

