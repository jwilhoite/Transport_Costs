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

%%%%%%%%  Elasaticity of Substitution  %%%%%%%%
gammaspace = 0.5:0.01:0.95;
sol_substitution = zeros(length(gammaspace),24);
flags = zeros(length(gammaspace),1);

t=1;

for n=1:length(gammaspace)
    gamma=gammaspace(n);
    fun = @(x) model_iceberg(x, gamma, alpha, delta, beta, a, tau);
    x0 = ones(1,24)/2;
    [x,~,flag] = fsolve(fun,x0);
    flags(n)=flag;
    sol_substitution(n,:)=x;
end 

elasticity = zeros(length(gammaspace),1);
welfare = zeros(length(gammaspace),1);
transport_gdp = zeros(length(gammaspace),1);

for n=1:length(gammaspace)
    x = 1-gammaspace(n);
    elasticity(n) = 1/x;
end 

for n=1:length(gammaspace)
    welfare(n) = (1+sol_substitution(n,20)*sol_substitution(n,23))/sol_substitution(n,15);
end 

for n=1:length(gammaspace)
    x=(sol_substitution(n,17)*sol_substitution(n,5)*tau(1))+(sol_substitution(n,17)*sol_substitution(n,6)*tau(2))+...
        (sol_substitution(n,18)*sol_substitution(n,7)*tau(3))+(sol_substitution(n,18)*sol_substitution(n,8)*tau(4));
    y=sol_substitution(n,15)*sol_substitution(n,1)+sol_substitution(n,16)*sol_substitution(n,2);
    transport_gdp(n)=x/y;
end 

figure
plot(elasticity,welfare)
xlabel('Elasticity of Substitution')
ylabel('Welfare');

figure
plot(elasticity,sol_substitution(:,9))
xlabel('Elasticity of Substitution')
ylabel('Region 1 Labor Share');
ylim([-0.1,0.8])

figure
plot(elasticity,transport_gdp)
xlabel('Elasticity of Substitution')
ylabel('Tranport GDP Share');


%%%%%%%%  Saving Output  %%%%%%%%
for n=1:3
    figname = num2str(get(figure(n),'Number'));
    saveas(figure(n),fullfile('/Users/johnwilhoite/Documents/MATLAB/Transport/Iceberg/iceberg_figures/iceberg_elasticity',strcat(figname,'.png')))
end 


