cd '/Users/johnwilhoite/Documents/MATLAB/Transport/Iceberg'
clear all 

%%%%%%%%  CALIBRATION  %%%%%%%%
a = zeros(2,1);
a(1) = 1; %productivity of region 1 commodity sector
a(2) = 1; %productivity of region 2 commodity sector

tau=zeros(4,1);
tau(1) = 1; %d_11, region 1 to 2 required transport services
tau(2) = 1.5; %d__12, region 1 to 2 required transport services
tau(3) = 1; %d_22
tau(4) = 1.5; %d_21

gamma = 0.75; 
beta = 0.99;
delta=0.75;
alpha=0.6;

%%%%%%%%  Commodity Productivity  %%%%%%%%
%%%%  Symmetric case %%%%
prodspace = 0.1:0.1:10;
sol_com_sym = zeros(length(prodspace),24);
flags = zeros(length(prodspace),1);

for n=1:length(prodspace)
    a(1)=prodspace(n);
    a(2)=prodspace(n);
    x0=ones(1,24);
    fun = @(x) model_iceberg(x, gamma, alpha, delta, beta, a, tau);
    [x,~,flag]=fsolve(fun,x0);
    sol_com_sym(n,:)=real(x);
    flags(n)=flag;
end 

welfare = zeros(length(prodspace),1);
transport_gdp = zeros(length(prodspace),1);

for n=1:length(prodspace)
    welfare(n) = (1+sol_com_sym(n,20)*sol_com_sym(n,23))/sol_com_sym(n,15);
end 

for n=1:length(prodspace)
    x=(sol_com_sym(n,17)*sol_com_sym(n,5)*tau(1))+(sol_com_sym(n,17)*sol_com_sym(n,6)*tau(2))+...
    (sol_com_sym(n,18)*sol_com_sym(n,7)*tau(3))+(sol_com_sym(n,18)*sol_com_sym(n,8)*tau(4));
    y=sol_com_sym(n,15)*sol_com_sym(n,1)+sol_com_sym(n,16)*sol_com_sym(n,2);
    transport_gdp(n)=x/y;
end 

figure
plot(prodspace,welfare)
xlabel('Commodity Productivity')
ylabel('Welfare');

figure
plot(prodspace,sol_com_sym(:,9))
xlabel('Commodity Productivity')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(prodspace,transport_gdp)
xlabel('Commodity Productivity')
ylabel('Tranport GDP Share');

%%%%  Asymmetric case %%%%
sol_com_asym = zeros(length(prodspace),24);
flags = zeros(length(prodspace),1);

a = zeros(2,1);
a(1) = 1; %productivity of region 1 commodity sector
a(2) = 1; %productivity of region 2 commodity sector

for n=1:length(prodspace)
    a(1)=prodspace(n);
    x0=ones(1,24);
    fun = @(x) model_iceberg(x, gamma, alpha, delta, beta, a, tau);
    [x,~,flag]=fsolve(fun,x0);
    sol_com_asym(n,:)=real(x);
    flags(n)=flag;
end 

welfare = zeros(length(prodspace),1);
transport_gdp = zeros(length(prodspace),1);

for n=1:length(prodspace)
    welfare(n) = (1+sol_com_asym(n,20)*sol_com_asym(n,23))/sol_com_asym(n,15);
end 

for n=1:length(prodspace)
    x=(sol_com_asym(n,17)*sol_com_asym(n,5)*tau(1))+(sol_com_asym(n,17)*sol_com_asym(n,6)*tau(2))+...
    (sol_com_asym(n,18)*sol_com_asym(n,7)*tau(3))+(sol_com_asym(n,18)*sol_com_asym(n,8)*tau(4));
    y=sol_com_asym(n,15)*sol_com_asym(n,1)+sol_com_asym(n,16)*sol_com_asym(n,2);
    transport_gdp(n)=x/y;
end 

figure
plot(prodspace,welfare)
xlabel('Region 1 Commodity Productivity')
ylabel('Welfare');

figure
plot(prodspace,sol_com_asym(:,9))
xlabel('Region 1 Commodity Productivity')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(prodspace,transport_gdp)
xlabel('Region 1 Commodity Productivity')
ylabel('Tranport GDP Share');


%%%%%%%%  Saving Output  %%%%%%%%
for n=1:6
    figname = num2str(get(figure(n),'Number'));
    saveas(figure(n),fullfile('/Users/johnwilhoite/Documents/MATLAB/Transport/Iceberg/iceberg_figures/iceberg_productivity',strcat(figname,'.png')))
end 
