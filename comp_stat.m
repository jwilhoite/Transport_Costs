cd '/Users/johnwilhoite/Documents/MATLAB/Transport'
clear all 

%%%%%%%%  CALIBRATION  %%%%%%%%
a = zeros(3,1);
a(1) = 1; %productivity of region 1 commodity sector
a(2) = 1; %productivity of region 2 commodity sector
a(3) = 1; %productivity of transport sector

d=zeros(4,1);
d(1) = 1; %d_11, region 1 to 2 required transport services
d(2) = 1.5; %d__12, region 1 to 2 required transport services
d(3) = 1; %d_22
d(4) = 1.5; %d_21
t = 1;

gamma = 0.75; 

%%%%%%%%   Intra-Regional Distance  %%%%%%%%
dspace_intra= 0:0.01:2;
sol = zeros(length(dspace_intra),21);
flags = zeros(length(dspace_intra),1);

for n=1:1:length(dspace_intra)
    d(1)=dspace_intra(n);
    d(3)=dspace_intra(n);
    fun = @(x) model(x, gamma, a, d, t);
    x0 = ones(1,21);
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol(n,:)=x;
end 
welfare = zeros(length(dspace_intra),1);
transport_gdp = zeros(length(dspace_intra),1);

for n=1:length(dspace_intra)
    welfare(n) = 1/sol(n,15);
end 

for n=1:length(dspace_intra)
    x=sol(n,19)*sol(n,9)+sol(n,20)*sol(n,10);
    y=sol(n,15)*sol(n,1)+sol(n,16)*sol(n,2);
    transport_gdp(n)=x/y;
end 

figure
plot(dspace_intra,welfare)
xlabel('Intra-Regional Distance')
ylabel('Welfare');

figure
plot(dspace_intra,sol(:,11)+sol(:,13))
xlabel('Intra-Regional Distance')
ylabel('Region 1 Labor Share');
ylim([-0.1,0.8])

figure
plot(dspace_intra,sol(:,13)+sol(:,14))
xlabel('Intra-Regional Distance')
ylabel('Tranport Labor Share');

figure
plot(dspace_intra,transport_gdp)
xlabel('Intra-Regional Distance')
ylabel('Tranport GDP Share');

%%%%%%%%   Inter-Regional Distance  %%%%%%%%
%%%%  Symmetric case %%%%

dspace_inter = 1:0.01:3;
sol = zeros(length(dspace_inter),21);
flags = zeros(length(dspace_inter),1);

d(1) = 1; %d_11, region 1 to 2 required transport services
d(2) = 1.5; %d__12, region 1 to 2 required transport services
d(3) = 1; %d_22
d(4) = 1.5; %d_21

for n=1:length(dspace_inter)
    d(2)=dspace_inter(n);
    d(4)=dspace_inter(n);
    fun = @(x) model(x, gamma, a, d, t);
    x0 = ones(1,21);
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol(n,:)=x;
end 

welfare = zeros(length(dspace_inter),1);
transport_gdp = zeros(length(dspace_inter),1);

for n=1:length(dspace_inter)
    welfare(n) = 1/sol(n,15);
end 

for n=1:length(dspace_inter)
    x=sol(n,19)*sol(n,9)+sol(n,20)*sol(n,10);
    y=sol(n,15)*sol(n,1)+sol(n,16)*sol(n,2);
    transport_gdp(n)=x/y;
end 

figure
plot(dspace_inter,welfare)
xlabel('Inter-Regional Distance')
ylabel('Welfare');

figure
plot(dspace_inter,sol(:,11)+sol(:,13))
xlabel('Inter-Regional Distance')
ylabel('Region 1 Labor Share');
ylim([-0.1,0.8])

figure
plot(dspace_inter,sol(:,13)+sol(:,14))
xlabel('Inter-Regional Distance')
ylabel('Tranport Labor Share');

figure
plot(dspace_inter,transport_gdp)
xlabel('Inter-Regional Distance')
ylabel('Tranport GDP Share');

%%%%  Asymmetric case %%%%
sol = zeros(length(dspace_inter),21);
flags = zeros(length(dspace_inter),1);

d(1) = 1; %d_11, region 1 to 2 required transport services
d(2) = 1.5; %d__12, region 1 to 2 required transport services
d(3) = 1; %d_22
d(4) = 1.5; %d_21

for n=1:length(dspace_inter)
    d(2)=dspace_inter(n);
    fun = @(x) model(x, gamma, a, d, t);
    x0 = ones(1,21);
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol(n,:)=x;
end 

welfare = zeros(length(dspace_inter),1);
transport_gdp = zeros(length(dspace_inter),1);

for n=1:length(dspace_inter)
    welfare(n) = 1/sol(n,15);
end 

for n=1:length(dspace_inter)
    x=sol(n,19)*sol(n,9)+sol(n,20)*sol(n,10);
    y=sol(n,15)*sol(n,1)+sol(n,16)*sol(n,2);
    transport_gdp(n)=x/y;
end 

figure
plot(dspace_inter,welfare)
xlabel('Region 1 to Region 2 Distance, d_12')
ylabel('Welfare');

figure
plot(dspace_inter,sol(:,11)+sol(:,13))
xlabel('Region 1 to Region 2 Distance, d_12')
ylabel('Region 1 Labor Share');

figure
plot(dspace_inter,sol(:,13)+sol(:,14))
xlabel('Region 1 to Region 2 Distance, d_12')
ylabel('Tranport Labor Share');

figure
plot(dspace_inter,transport_gdp)
xlabel('Region 1 to Region 2 Distance, d_12')
ylabel('Tranport GDP Share');

