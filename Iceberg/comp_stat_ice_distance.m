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

%%%%%%%%   Intra-Regional Distance  %%%%%%%%
tauspace_intra= 0:0.01:30;
sol_intra = zeros(length(tauspace_intra),24);
flags = zeros(length(tauspace_intra),1);

for n=1:1:length(tauspace_intra)
    tau(1)=tauspace_intra(n);
    tau(3)=tauspace_intra(n);
    fun = @(x) model_iceberg(x, gamma, alpha, delta, beta, a, tau);
    x0 = ones(1,24);
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol_intra(n,:)=real(x);
end 
welfare = zeros(length(tauspace_intra),1);
transport_gdp = zeros(length(tauspace_intra),1);

for n=1:length(tauspace_intra)
    welfare(n) = (1+sol_intra(n,20)*sol_intra(n,23))/sol_intra(n,15);
end 

for n=1:length(tauspace_intra)
    x=(sol_intra(n,17)*sol_intra(n,5)*tauspace_intra(n))+(sol_intra(n,17)*sol_intra(n,6)*tau(2))+...
    (sol_intra(n,18)*sol_intra(n,7)*tauspace_intra(n))+(sol_intra(n,18)*sol_intra(n,8)*tau(4));
    y=sol_intra(n,15)*sol_intra(n,1)+sol_intra(n,16)*sol_intra(n,2);
    transport_gdp(n)=x/y;
end 

figure
plot(tauspace_intra,welfare)
xlabel('Intra-Regional Distance')
ylabel('Welfare');

figure
plot(tauspace_intra,sol_intra(:,9))
xlabel('Intra-Regional Distance')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(tauspace_intra,transport_gdp)
xlabel('Intra-Regional Distance')
ylabel('Tranport GDP Share');

%%%%%%%%   Inter-Regional Distance  %%%%%%%%
%%%%  Symmetric case %%%%
tauspace_inter = 0:0.01:30;
sol_inter_sym = zeros(length(tauspace_inter),24);
flags = zeros(length(tauspace_inter),1);

tau(1) = 1; %d_11, region 1 to 2 required transport services
tau(2) = 1.5; %d__12, region 1 to 2 required transport services
tau(3) = 1; %d_22
tau(4) = 1.5; %d_21

for n=1:length(tauspace_inter)
    tau(2)=tauspace_inter(n);
    tau(4)=tauspace_inter(n);
    fun = @(x) model_iceberg(x, gamma, alpha, delta, beta, a, tau);
    x0 = ones(1,24);
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol_inter_sym(n,:)=real(x);
end 

welfare = zeros(length(tauspace_inter),1);
transport_gdp = zeros(length(tauspace_inter),1);

for n=1:length(tauspace_inter)
    welfare(n) = (1+sol_inter_sym(n,20)*sol_inter_sym(n,23))/sol_inter_sym(n,15);
end 

for n=1:length(tauspace_inter)
    x=(sol_inter_sym(n,17)*sol_inter_sym(n,5)*tau(1))+(sol_inter_sym(n,17)*sol_inter_sym(n,6)*tauspace_inter(n))+...
    (sol_inter_sym(n,18)*sol_inter_sym(n,7)*tau(3))+(sol_inter_sym(n,18)*sol_inter_sym(n,8)*tauspace_inter(n));
    y=sol_inter_sym(n,15)*sol_inter_sym(n,1)+sol_inter_sym(n,16)*sol_inter_sym(n,2);
    transport_gdp(n)=x/y;
end 

figure
plot(tauspace_inter,welfare)
xlabel('Inter-Regional Distance')
ylabel('Welfare');

figure
plot(tauspace_inter,sol_inter_sym(:,9))
xlabel('Inter-Regional Distance')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(tauspace_inter,transport_gdp)
xlabel('Inter-Regional Distance')
ylabel('Tranport GDP Share');

%%%%  Asymmetric case %%%%
sol_inter_asym = zeros(length(tauspace_inter),24);
flags = zeros(length(tauspace_inter),1);

tau(1) = 1; %d_11, region 1 to 2 required transport services
tau(2) = 1.5; %d__12, region 1 to 2 required transport services
tau(3) = 1; %d_22
tau(4) = 1.5; %d_21

for n=1:length(tauspace_inter)
    tau(2)=tauspace_inter(n);
    fun = @(x) model_iceberg(x, gamma, alpha, delta, beta, a, tau);
    x0 = ones(1,24);
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol_inter_asym(n,:)=x;
end 
welfare = zeros(length(tauspace_inter),1);
transport_gdp = zeros(length(tauspace_inter),1);

for n=1:length(tauspace_inter)
    welfare(n) = (1+sol_inter_asym(n,20)*sol_inter_asym(n,23))/sol_inter_asym(n,15);
end 

for n=1:length(tauspace_inter)
    x=(sol_inter_asym(n,17)*sol_inter_asym(n,5)*tau(1))+(sol_inter_asym(n,17)*sol_inter_asym(n,6)*tauspace_inter(n))+...
    (sol_inter_asym(n,18)*sol_inter_asym(n,7)*tau(3))+(sol_inter_asym(n,18)*sol_inter_asym(n,8)*tau(4));
    y=sol_inter_asym(n,15)*sol_inter_asym(n,1)+sol_inter_asym(n,16)*sol_inter_asym(n,2);
    transport_gdp(n)=x/y;
end 

figure
plot(tauspace_inter,welfare)
xlabel('Region 1 to Region 2 Distance, d_{12}')
ylabel('Welfare');

figure
plot(tauspace_inter,sol_inter_asym(:,9))
xlabel('Region 1 to Region 2 Distance, d_{12}')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(tauspace_inter,transport_gdp)
xlabel('Region 1 to Region 2 Distance, d_{12}')
ylabel('Tranport GDP Share');

%%%%%%%%  Saving Output  %%%%%%%%
for n=1:9
    figname = num2str(get(figure(n),'Number'));
    saveas(figure(n),fullfile('/Users/johnwilhoite/Documents/MATLAB/Transport/Iceberg/iceberg_figures/iceberg_distance',strcat(figname,'.png')))
end 
