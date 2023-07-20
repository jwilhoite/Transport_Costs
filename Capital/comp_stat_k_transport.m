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

%%%%%%%%  Transport Costs  %%%%%%%%
tspace = 0:0.01:3;
sol_transport = zeros(length(tspace),32);
flags = zeros(length(tspace),1);

for n=1:length(tspace)
    t=tspace(n);
    fun = @(x) model_k(x, gamma, alpha, alpha_t, delta, beta, a, d, t);
    x0 = ones(1,32);
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol_transport(n,:)=x;
end 

welfare1 = zeros(length(tspace),1);
transport_gdp_share = zeros(length(tspace),1);

for n=1:length(tspace)
    welfare(n) = (1+sol_transport(n,28)*sol_transport(n,31))/sol_transport(n,21);
end  

for n=1:length(tspace)
    x=sol_transport(n,25)*sol_transport(n,9)+sol_transport(n,26)*sol_transport(n,10);
    y=sol_transport(n,21)*sol_transport(n,1)+sol_transport(n,22)*sol_transport(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(tspace,welfare)
xlabel('Transport Cost Level')
ylabel('Welfare');

figure
plot(tspace,sol_transport(:,11)+sol_transport(:,13))
xlabel('Transport Cost Level')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(tspace,sol_transport(:,12)+sol_transport(:,14))
xlabel('Transport Cost Level')
ylabel('Region 2 Labor Share');
ylim([-0.1,1.1])

figure
plot(tspace,sol_transport(:,13)+sol_transport(:,14))
xlabel('Transport Cost Level')
ylabel('Tranport Labor Share');

figure
plot(tspace,transport_gdp_share)
xlabel('Transport Cost Level')
ylabel('Tranport GDP Share');

%%%%%%%%  Elasaticity of Substitution  %%%%%%%%
gammaspace = 0.5:0.01:0.95;
sol_substitution = zeros(length(gammaspace),32);
flags = zeros(length(gammaspace),1);

t=1;

for n=1:length(gammaspace)
    gamma=gammaspace(n);
    fun = @(x) model_k(x, gamma, alpha, alpha_t, delta, beta, a, d, t);
    x0 = ones(1,32)/2;
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol_substitution(n,:)=x;
end 

elasticity = zeros(length(gammaspace),1);
welfare1 = zeros(length(gammaspace),1);
welfare2 = zeros(length(gammaspace),1);
transport_gdp_share = zeros(length(gammaspace),1);

for n=1:length(gammaspace)
    x = 1-gammaspace(n);
    elasticity(n) = 1/x;
end 

for n=1:length(gammaspace)
    welfare1(n) = (1+sol_substitution(n,28)*sol_substitution(n,31))/sol_substitution(n,21);
end 

for n=1:length(gammaspace)
    x=sol_substitution(n,25)*sol_substitution(n,9)+sol_substitution(n,26)*sol_substitution(n,10);
    y=sol_substitution(n,21)*sol_substitution(n,1)+sol_substitution(n,22)*sol_substitution(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(elasticity,welfare1)
xlabel('Elasticity of Substitution')
ylabel('Welfare');

figure
plot(elasticity,sol_substitution(:,11)+sol_substitution(:,13))
xlabel('Elasticity of Substitution')
ylabel('Region 1 Labor Share');
ylim([-0.1,1.1])

figure
plot(elasticity,sol_substitution(:,12)+sol_substitution(:,14))
xlabel('Elasticity of Substitution')
ylabel('Region 2 Labor Share');
ylim([-0.1,1.1])

figure
plot(elasticity,sol_substitution(:,13)+sol_substitution(:,14))
xlabel('Elasticity of Substitution')
ylabel('Tranport Labor Share');

figure
plot(elasticity,transport_gdp_share)
xlabel('Elasticity of Substitution')
ylabel('Tranport GDP Share');


%%%%%%%%  Saving Output  %%%%%%%%
for n=1:5
    figname = num2str(get(figure(n),'Number'));
    saveas(figure(n),fullfile('/Users/johnwilhoite/Documents/MATLAB/Transport/Capital/capital_figures/capital_transport',strcat(figname,'.png')))
end 

for n=6:10
    figname = num2str(get(figure(n),'Number'));
    saveas(figure(n),fullfile('/Users/johnwilhoite/Documents/MATLAB/Transport/Capital/capital_figures/capital_elasticity',strcat(figname,'.png')))
end 

