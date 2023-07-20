cd '/Users/johnwilhoite/Documents/MATLAB/Transport/Capital'
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
beta = 0.99;
delta=0.75;
alpha=0.5;
alpha_t=0.5;

%%%%%%%%   Intra-Regional Distance  %%%%%%%%
dspace_intra= 0:0.01:5;
sol_intra = zeros(length(dspace_intra),32);
flags = zeros(length(dspace_intra),1);

for n=1:1:length(dspace_intra)
    d(1)=dspace_intra(n);
    d(3)=dspace_intra(n);
    fun = @(x) model_k(x, gamma, delta, beta, alpha, alpha_t, a, d, t);
    x0 = ones(1,32);
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol_intra(n,:)=real(x);
end 
welfare = zeros(length(dspace_intra),1);
transport_gdp = zeros(length(dspace_intra),1);

for n=1:length(dspace_intra)
    welfare(n) = (1+sol_intra(n,28)*sol_intra(n,31))/sol_intra(n,21);
end 

for n=1:length(dspace_intra)
    x=sol_intra(n,25)*sol_intra(n,9)+sol_intra(n,26)*sol_intra(n,10);
    y=sol_intra(n,21)*sol_intra(n,1)+sol_intra(n,22)*sol_intra(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(dspace_intra,welfare)
xlabel('Intra-Regional Distance')
ylabel('Welfare');

figure
plot(dspace_intra,sol_intra(:,11)+sol_intra(:,13))
xlabel('Intra-Regional Distance')
ylabel('Region 1 Labor Share');
ylim([-0.1,0.8])

figure
plot(dspace_intra,sol_intra(:,13)+sol_intra(:,14))
xlabel('Intra-Regional Distance')
ylabel('Tranport Labor Share');

figure
plot(dspace_intra,transport_gdp_share)
xlabel('Intra-Regional Distance')
ylabel('Tranport GDP Share');

%%%%%%%%   Inter-Regional Distance  %%%%%%%%
%%%%  Symmetric case %%%%
dspace_inter = 0:0.01:30;
sol_inter_sym = zeros(length(dspace_inter),32);
flags = zeros(length(dspace_inter),1);

d(1) = 1; %d_11, region 1 to 2 required transport services
d(2) = 1.5; %d__12, region 1 to 2 required transport services
d(3) = 1; %d_22
d(4) = 1.5; %d_21

for n=1:length(dspace_inter)
    d(2)=dspace_inter(n);
    d(4)=dspace_inter(n);
    fun = @(x) model_k(x, gamma, delta, beta, alpha, alpha_t, a, d, t);
    x0 = ones(1,32);
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol_inter_sym(n,:)=real(x);
end 

welfare = zeros(length(dspace_inter),1);
transport_gdp = zeros(length(dspace_inter),1);

for n=1:length(dspace_inter)
    welfare(n) = (1+sol_inter_sym(n,28)*sol_inter_sym(n,31))/sol_inter_sym(n,21);
end 

for n=1:length(dspace_inter)
    x=sol_inter_sym(n,25)*sol_inter_sym(n,9)+sol_inter_sym(n,26)*sol_inter_sym(n,10);
    y=sol_inter_sym(n,21)*sol_inter_sym(n,1)+sol_inter_sym(n,22)*sol_inter_sym(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(dspace_inter,welfare)
xlabel('Inter-Regional Distance')
ylabel('Welfare');

figure
plot(dspace_inter,sol_inter_sym(:,11)+sol_inter_sym(:,13))
xlabel('Inter-Regional Distance')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(dspace_inter,sol_inter_sym(:,13)+sol_inter_sym(:,14))
xlabel('Inter-Regional Distance')
ylabel('Tranport Labor Share');

figure
plot(dspace_inter,transport_gdp_share)
xlabel('Inter-Regional Distance')
ylabel('Tranport GDP Share');

%%%%  Asymmetric case %%%%
sol_inter_asym = zeros(length(dspace_inter),32);
flags = zeros(length(dspace_inter),1);

d(1) = 1; %d_11, region 1 to 2 required transport services
d(2) = 1.5; %d__12, region 1 to 2 required transport services
d(3) = 1; %d_22
d(4) = 1.5; %d_21

for n=1:length(dspace_inter)
    d(2)=dspace_inter(n);
    fun = @(x) model_k(x, gamma, delta, beta, alpha, alpha_t, a, d, t);
    x0 = ones(1,32);
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol_inter_asym(n,:)=x;
end 

welfare = zeros(length(dspace_inter),1);
transport_gdp = zeros(length(dspace_inter),1);

for n=1:length(dspace_inter)
    welfare(n) = (1+sol_inter_asym(n,28)*sol_inter_asym(n,31))/sol_inter_asym(n,21);
end 

for n=1:length(dspace_inter)
    x=sol_inter_asym(n,25)*sol_inter_asym(n,9)+sol_inter_asym(n,26)*sol_inter_asym(n,10);
    y=sol_inter_asym(n,21)*sol_inter_asym(n,1)+sol_inter_asym(n,22)*sol_inter_asym(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(dspace_inter,welfare)
xlabel('Region 1 to Region 2 Distance, d_{12}')
ylabel('Welfare');

figure
plot(dspace_inter,sol_inter_asym(:,11)+sol_inter_asym(:,13))
xlabel('Region 1 to Region 2 Distance, d_{12}')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(dspace_inter,sol_inter_asym(:,13)+sol_inter_asym(:,14))
xlabel('Region 1 to Region 2 Distance, d_{12}')
ylabel('Tranport Labor Share');

figure
plot(dspace_inter,transport_gdp_share)
xlabel('Region 1 to Region 2 Distance, d_{12}')
ylabel('Tranport GDP Share');

%%%%%%%%  Saving Output  %%%%%%%%
%for n=1:12
    %figname = num2str(get(figure(n),'Number'));
    %saveas(figure(n),fullfile('/Users/johnwilhoite/Documents/MATLAB/Transport/distance_figures',strcat(figname,'.png')))
%end 