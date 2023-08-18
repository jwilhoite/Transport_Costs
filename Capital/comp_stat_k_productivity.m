cd '/Users/johnwilhoite/Documents/MATLAB/Transport/Capital'
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
alpha=0.5;
alpha_t=0.5;

%%%%%%%%  Commodity Productivity  %%%%%%%%
%%%%  Symmetric case %%%%
rspace=0.65:0.01:10;
f=zeros(1,1);
sol=zeros(1,29);

prodspace = 0.1:0.1:2.5;
sol_com_sym = zeros(length(prodspace),29);
solutions_com_sym=zeros(length(prodspace),29);
flags = zeros(length(prodspace),1);

for n=1:length(prodspace)
    a(1)=prodspace(n);
    a(2)=prodspace(n);
    for i=1:length(rspace)
        r=rspace(i);
        fun = @(x) model_k_r(x, gamma, alpha, alpha_t, delta, beta, a, d, t, r);
        x0 = ones(1,28);
        options=optimoptions('fsolve','Algorithm','levenberg-marquardt');
        [x,~,flag] = fsolve(fun,x0,options);
        f=((x(25)+r*x(27))/x(19))-((x(26)+r*x(28))/x(20));
        if abs(f)<1e-5 && abs(imag(x(25)))<1e-9
            break 
        end 
    end 
    flags(n)=flag;
    sol(1:18)=real(x(1:18));
    sol(27:28)=real(x(27:28));
    sol(19:26)=real(x(19:26))/real(x(25));
    sol(29)=r/real(x(25));
    sol_com_sym(n,:)=sol;
    solutions_com_sym(n,1:28)=x;
    solutions_com_sym(n,29)=r;
end 

welfare = zeros(length(prodspace),1);
transport_gdp_share = zeros(length(prodspace),1);

for n=1:length(prodspace)
    welfare(n) = (sol_com_sym(n,25)+sol_com_sym(n,29)*sol_com_sym(n,27))/sol_com_sym(n,19);
end 

for n=1:length(prodspace)
    x=sol_com_sym(n,25)*sol_com_sym(n,9)+sol_com_sym(n,26)*sol_com_sym(n,10);
    y=sol_com_sym(n,19)*sol_com_sym(n,1)+sol_com_sym(n,20)*sol_com_sym(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(prodspace,welfare)
xlabel('Commodity Productivity')
ylabel('Welfare');

figure
plot(prodspace,sol_com_sym(:,11)+sol_com_sym(:,13))
xlabel('Commodity Productivity')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(prodspace,sol_com_sym(:,13)+sol_com_sym(:,14))
xlabel('Commodity Productivity')
ylabel('Tranport Labor Share');

figure
plot(prodspace,transport_gdp_share)
xlabel('Commodity Productivity')
ylabel('Tranport GDP Share');

%%%%  Asymmetric case %%%%
sol_com_asym = zeros(length(prodspace),29);
solutions_com_asym=zeros(length(prodspace),29);
flags = zeros(length(prodspace),1);

a = zeros(3,1);
a(1) = 1; %productivity of region 1 commodity sector
a(2) = 1; %productivity of region 2 commodity sector
a(3) = 1; %productivity of transport sector

for n=1:length(prodspace)
    a(1)=prodspace(n);
    for i=1:length(rspace)
        r=rspace(i);
        fun = @(x) model_k_r(x, gamma, alpha, alpha_t, delta, beta, a, d, t, r);
        x0 = ones(1,28);
        options=optimoptions('fsolve','Algorithm','levenberg-marquardt');
        [x,~,flag] = fsolve(fun,x0,options);
        f=((x(25)+r*x(27))/x(19))-((x(26)+r*x(28))/x(20));
        if abs(f)<1e-5 && abs(imag(x(25)))<1e-9
            break 
        end 
    end 
    flags(n)=flag;
    sol(1:18)=real(x(1:18));
    sol(27:28)=real(x(27:28));
    sol(19:26)=real(x(19:26))/real(x(25));
    sol(29)=r/real(x(25));
    solutions_com_asym(n,1:28)=x;
    solutions_com_asym(n,29)=r;
    sol_com_asym(n,:)=sol;
end 

welfare = zeros(length(prodspace),1);
transport_gdp_share = zeros(length(prodspace),1);

for n=1:length(prodspace)
    welfare(n) = (sol_com_asym(n,25)+sol_com_asym(n,29)*sol_com_asym(n,27))/sol_com_asym(n,19);
end 

for n=1:length(prodspace)
    x=sol_com_asym(n,25)*sol_com_asym(n,9)+sol_com_asym(n,26)*sol_com_asym(n,10);
    y=sol_com_asym(n,19)*sol_com_asym(n,1)+sol_com_asym(n,20)*sol_com_asym(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(prodspace,welfare)
xlabel('Region 1 Commodity Productivity')
ylabel('Welfare');

figure
plot(prodspace,sol_com_asym(:,11)+sol_com_asym(:,13))
xlabel('Region 1 Commodity Productivity')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(prodspace,sol_com_asym(:,13)+sol_com_asym(:,14))
xlabel('Region 1 Commodity Productivity')
ylabel('Tranport Labor Share');

figure
plot(prodspace,transport_gdp_share)
xlabel('Region 1 Commodity Productivity')
ylabel('Tranport GDP Share');

%%%%%%%%  Transport Productivity  %%%%%%%%
sol_transport = zeros(length(prodspace),29);
solutions_transport = zeros(length(prodspace),29);
flags = zeros(length(prodspace),1);

a = zeros(3,1);
a(1) = 1; %productivity of region 1 commodity sector
a(2) = 1; %productivity of region 2 commodity sector
a(3) = 1; %productivity of transport sector

for n=1:length(prodspace)
    a(3)=prodspace(n);
    for i=1:length(rspace)
        r=rspace(i);
        fun = @(x) model_k_r(x, gamma, alpha, alpha_t, delta, beta, a, d, t, r);
        x0 = ones(1,28);
        options=optimoptions('fsolve','Algorithm','levenberg-marquardt');
        [x,~,flag] = fsolve(fun,x0,options);
        f=((x(25)+r*x(27))/x(19))-((x(26)+r*x(28))/x(20));
        if abs(f)<1e-5 && abs(imag(x(25)))<1e-9
            break 
        end 
    end 
    flags(n)=flag;
    sol(1:18)=real(x(1:18));
    sol(27:28)=real(x(27:28));
    sol(19:26)=real(x(19:26))/real(x(25));
    sol(29)=r/real(x(25));
    solutions(n,1:28)=x;
    solutions(n,29)=r;
    sol_transport(n,:)=sol;
end 

welfare = zeros(length(prodspace),1);
transport_gdp_share = zeros(length(prodspace),1);

for n=1:length(prodspace)
    welfare(n) = (sol_transport(n,25)+sol_transport(n,29)*sol_transport(n,27))/sol_transport(n,19);
end 

for n=1:length(prodspace)
    x=sol_transport(n,25)*sol_transport(n,9)+sol_transport(n,26)*sol_transport(n,10);
    y=sol_transport(n,19)*sol_transport(n,1)+sol_transport(n,20)*sol_transport(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(prodspace,welfare)
xlabel('Transport Productivity')
ylabel('Welfare');

figure
plot(prodspace,sol_transport(:,11)+sol_transport(:,13))
xlabel('Transport Productivity')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(prodspace,sol_transport(:,13)+sol_transport(:,14))
xlabel('Transport Productivity')
ylabel('Tranport Labor Share');

figure
plot(prodspace,transport_gdp_share)
xlabel('Transport Productivity')
ylabel('Tranport GDP Share');

%%%%%%%%  Saving Output  %%%%%%%%
for n=1:12
    figname = num2str(get(figure(n),'Number'));
    saveas(figure(n),fullfile('/Users/johnwilhoite/Documents/MATLAB/Transport/Capital/capital_figures/capital_productivity',strcat(figname,'.png')))
end 


