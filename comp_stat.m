cd '/Users/johnwilhoite/Documents/MATLAB/TransportRA'
clear all 

%%%%  CALIBRATION  %%%%
a = zeros(3,1);
a(1) = 1; %productivity of region 1 commodity sector
a(2) = 1; %productivity of region 2 commodity sector
a(3) = 1; %productivity of transport sector

d=zeros(4,1);
d(1) = 1; %region 1 to 2 required transport services
d(2) = 1.5; %region 2 to 1 required transport services
d(3) = 1;
d(4) = 1.5;
t = 1;

gamma = 0.75; 

%%%%   Intra-Regional Distance  %%%%
dspace= 0:0.01:2;
sol = zeros(length(dspace),21);
flags = zeros(length(dspace),1);

for n=1:1:length(dspace)
    d(1)=dspace(n);
    fun = @(x) model(x,gamma, a, d, t);
    x0 = ones(1,21);
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol(n,:)=x;
end 
    
