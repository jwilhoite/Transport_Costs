cd '/Users/johnwilhoite/Documents/MATLAB/Transport'
clear all 

%%%%%%%%  CALIBRATION  %%%%%%%%
a = zeros(3,1);
a(1) = 1; %productivity of region 1 commodity sector
a(2) = 1; %productivity of region 2 commodity sector
a(3) = 1;

d=zeros(4,1);
d(1) = 1; %d_11, region 1 to 2 required transport services
d(2) = 1.5; %d__12, region 1 to 2 required transport services
d(3) = 1; %d_22
d(4) = 1.5; %d_21
t = 1;

gamma = 0.75; 
beta = 0.99;
delta=0.75;
alpha=0.6;
alpha_t=0.8;


%%%%%%%%  Commodity Productivity  %%%%%%%%
%%%%  Symmetric case %%%%
prodspace = 0.1:0.1:10;
sol_com_sym = zeros(length(prodspace),32);
flags = zeros(length(prodspace),1);

for n=1:length(prodspace)
    a(1)=prodspace(n);
    a(2)=prodspace(n);
    x0=ones(1,32);
    fun = @(x) model_k(x, gamma, delta, beta, alpha, alpha_t, a, d, t);
    [x,~,flag]=fsolve(fun,x0);
    sol_com_sym(n,:)=real(x);
    flags(n)=flag;
end 

welfare = zeros(length(prodspace),1);
transport_gdp = zeros(length(prodspace),1);

for n=1:length(prodspace)
    welfare(n) = (1+sol_com_sym(n,28)*sol_com_sym(n,31))/sol_com_sym(n,21);
end 

for n=1:length(prodspace)
    x=sol_com_sym(n,25)*sol_com_sym(n,9)+sol_com_sym(n,26)*sol_com_sym(n,10);
    y=sol_com_sym(n,21)*sol_com_sym(n,1)+sol_com_sym(n,22)*sol_com_sym(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(prodspace,welfare)
xlabel('Intra-Regional Distance')
ylabel('Welfare');

figure
plot(prodspace,sol_com_sym(:,11)+sol_com_sym(:,13))
xlabel('Intra-Regional Distance')
ylabel('Region 1 Labor Share');
ylim([-0.1,0.8])

figure
plot(prodspace,sol_com_sym(:,13)+sol_com_sym(:,14))
xlabel('Intra-Regional Distance')
ylabel('Tranport Labor Share');

figure
plot(prodspace,transport_gdp_share)
xlabel('Intra-Regional Distance')
ylabel('Tranport GDP Share');

%%%%  Asymmetric case %%%%
sol_com_asym = zeros(length(prodspace),32);
flags = zeros(length(prodspace),1);

a = zeros(3,1);
a(1) = 1; %productivity of region 1 commodity sector
a(2) = 1; %productivity of region 2 commodity sector
a(3) = 1; %productivity of transport sector

for n=1:length(prodspace)
    a(1)=prodspace(n);
    x0=ones(1,32);
    fun = @(x) model_k(x, gamma, delta, beta, alpha, alpha_t, a, d, t);
    [x,~,flag]=fsolve(fun,x0);
    sol_com_asym(n,:)=real(x);
    flags(n)=flag;
end 

welfare = zeros(length(prodspace),1);
transport_gdp = zeros(length(prodspace),1);

for n=1:length(prodspace)
    welfare(n) = (1+sol_com_asym(n,28)*sol_com_asym(n,31))/sol_com_asym(n,21);
end 

for n=1:length(dspace_intra)
    x=sol_com_asym(n,25)*sol_com_asym(n,9)+sol_com_asym(n,26)*sol_com_asym(n,10);
    y=sol_com_asym(n,21)*sol_com_asym(n,1)+sol_com_asym(n,22)*sol_com_asym(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(prodspace,welfare)
xlabel('Intra-Regional Distance')
ylabel('Welfare');

figure
plot(prodspace,sol_com_asym(:,11)+sol_com_asym(:,13))
xlabel('Intra-Regional Distance')
ylabel('Region 1 Labor Share');
ylim([-0.1,0.8])

figure
plot(prodspace,sol_com_asym(:,13)+sol_com_asym(:,14))
xlabel('Intra-Regional Distance')
ylabel('Tranport Labor Share');

figure
plot(prodspace,transport_gdp_share)
xlabel('Intra-Regional Distance')
ylabel('Tranport GDP Share');

%%%%%%%%  Transport Productivity  %%%%%%%%
sol_transport = zeros(length(prodspace),32);
flags = zeros(length(prodspace),1);

a = zeros(3,1);
a(1) = 1; %productivity of region 1 commodity sector
a(2) = 1; %productivity of region 2 commodity sector
a(3) = 1; %productivity of transport sector

for n=1:length(prodspace)
    a(3)=prodspace(n);
    x0=ones(1,32)/2;
    fun = @(x) model_k(x, gamma, delta, beta, alpha, alpha_t, a, d, t);
    [x,~,flag]=fsolve(fun,x0);
    sol_transport(n,:)=real(x);
    flags(n)=flag;
end 

welfare = zeros(length(prodspace),1);
transport_gdp = zeros(length(prodspace),1);

for n=1:length(prodspace)
    welfare(n) = (1+sol_transport(n,28)*sol_transport(n,31))/sol_transport(n,21);
end 

for n=1:length(prodspace)
    x=sol_transport(n,25)*sol_transport(n,9)+sol_transport(n,26)*sol_transport(n,10);
    y=sol_transport(n,21)*sol_transport(n,1)+sol_transport(n,22)*sol_transport(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(prodspace,welfare)
xlabel('Intra-Regional Distance')
ylabel('Welfare');

figure
plot(prodspace,sol_transport(:,11)+sol_transport(:,13))
xlabel('Intra-Regional Distance')
ylabel('Region 1 Labor Share');
ylim([-0.1,0.8])

figure
plot(prodspace,sol_transport(:,13)+sol_transport(:,14))
xlabel('Intra-Regional Distance')
ylabel('Tranport Labor Share');

figure
plot(prodspace,transport_gdp_share)
xlabel('Intra-Regional Distance')
ylabel('Tranport GDP Share');

%%%%%%%%  Saving Output  %%%%%%%%
%for n=1:12
    %figname = num2str(get(figure(n),'Number'));
    %saveas(figure(n),fullfile('/Users/johnwilhoite/Documents/MATLAB/Transport/productivity_figures',strcat(figname,'.png')))
%end 
