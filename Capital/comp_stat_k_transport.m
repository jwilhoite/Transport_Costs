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


%%%%%%%%  Elasaticity of Substitution  %%%%%%%%
gammaspace = 0.5:0.01:0.95;
sol_substitution = zeros(length(gammaspace),32);
flags = zeros(length(gammaspace),1);

t=1;

for n=1:length(gammaspace)
    gamma=gammaspace(n);
    fun = @(x) model(x, gamma, a, d, t);
    x0 = ones(1,32)/2;
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
    welfare(n) = (1+sol_substitution(n,28)*sol_substitution(n,31))/sol_substitution(n,21);
end 

for n=1:length(gammaspace)
    x=sol_substitution(n,25)*sol_substitution(n,9)+sol_substitution(n,26)*sol_substitution(n,10);
    y=sol_substitution(n,21)*sol_substitution(n,1)+sol_substitution(n,22)*sol_substitution(n,2);
    transport_gdp_share(n)=x/y;
end 

figure
plot(elasticity,welfare)
xlabel('Elasticity of Substitution')
ylabel('Welfare');

figure
plot(elasticity,sol_substitution(:,11)+sol_substitution(:,13))
xlabel('Elasticity of Substitution')
ylabel('Region 1 Labor Share');
ylim([-0.1,0.8])

figure
plot(elasticity,sol_substitution(:,13)+sol_substitution(:,14))
xlabel('Elasticity of Substitution')
ylabel('Tranport Labor Share');

figure
plot(elasticity,transport_gdp)
xlabel('Elasticity of Substitution')
ylabel('Tranport GDP Share');


%%%%%%%%  Saving Output  %%%%%%%%
%for n=1:4
 %   figname = num2str(get(figure(n),'Number'));
  %  saveas(figure(n),fullfile('/Users/johnwilhoite/Documents/MATLAB/Transport/transport_figures',strcat(figname,'.png')))
%end 

%for n=5:8
 %   figname = num2str(get(figure(n),'Number'));
  %  saveas(figure(n),fullfile('/Users/johnwilhoite/Documents/MATLAB/Transport/elasticity_figures',strcat(figname,'.png')))
%end 

