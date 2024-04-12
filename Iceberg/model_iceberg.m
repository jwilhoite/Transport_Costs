function F = model_iceberg(x, gamma, alpha, delta, beta, a, tau)

%test

%x(1)=Q_tilde1
%x(2)=Q_tilde2
%x(3)=Q_1
%x(4)=Q_2
%x(5)=z_11
%x(6)=z_12
%x(7)=z_22
%x(8)=z_21

%x(9)=L_1
%x(10)=L_2

%x(11)=K_hat1
%x(12)=K_hat2
%x(13)=K_1
%x(14)=K_2

%x(15)=p_tilde1
%x(16)=p_tilde2
%x(17)=p_1
%x(18)=p_2
%x(19)=w_2
%x(20)=r

%x(21)=C_tilde1
%x(22)=C_tilde2

%x(23)=k_1
%x(24)=k_2

%Technology
F(1)=((0.5^(1-gamma))*(x(5)^gamma)+(0.5^(1-gamma))*(x(8)^gamma))^(1/gamma)-x(1); %Q_tilde1 production function
F(2)=((0.5^(1-gamma))*(x(7)^gamma)+(0.5^(1-gamma))*(x(6)^gamma))^(1/gamma)-x(2); %Q_tilde2 production function
F(3)=a(1)*(x(9)^(1-alpha))*(x(13)^alpha)-x(3); %Q_1 production function
F(4)=a(2)*(x(10)^(1-alpha))*(x(14)^alpha)-x(4); %Q_2 production function

%Producer Optimization
F(5)=((1/a(1))*(x(20)*((1-alpha)/alpha))^alpha)*x(3)-x(9); %L_1 factor demand
F(6)=((1/a(1))*((1/x(20))*(alpha/(1-alpha)))^(1-alpha))*x(3)-x(13); %K_1 factor demand
F(7)=((1/a(2))*((x(20)/x(19))*((1-alpha)/alpha))^alpha)*x(4)-x(10); %L_2 factor demand
F(8)=((1/a(2))*((x(19)/x(20))*(alpha/(1-alpha)))^(1-alpha))*x(4)-x(14); %K_2 factor demnd

F(9)=0.5*x(1)*(x(15)/(x(17)*(1+tau(1))))^(1/(1-gamma))-x(5); %optimal demand for Z_11
F(10)=0.5*x(1)*(x(15)/(x(18)*(1+tau(4))))^(1/(1-gamma))-x(8); %optimal demand for Z_21
F(11)=0.5*x(2)*(x(16)/(x(18)*(1+tau(3))))^(1/(1-gamma))-x(7); %optimal demand for Z_22
F(12)=0.5*x(2)*(x(16)/(x(17)*(1+tau(2))))^(1/(1-gamma))-x(6); %optimal demand for Z_12

%Consumer Optimization
F(13)=x(9)+(x(20)-delta*x(15))*x(11)-x(15)*x(21); %Region 1 aggregate budget constraint 
F(14)=x(19)*x(10)+(x(20)-delta*x(16))*x(12)-x(16)*x(22); %Region 2 aggregate budget constraint 
F(15)=beta*(x(15)*(1-delta)+x(20))-x(15); %Region 1 Euler equation
F(16)=beta*(x(16)*(1-delta)+x(20))-x(16); %Region 2 aggregate budget constraint 

%Market Clearing Conditions
F(17)=x(21)+delta*x(11)-x(1); %Q_tilde1 market clearing condition
F(18)=x(22)+delta*x(12)-x(2); %Q_tilde2 market clearing condition
F(19)=x(5)*(1+tau(1))+x(6)*(1+tau(2))-x(3); %Q_1 market clearing condition
F(20)=x(7)*(1+tau(3))+x(8)*(1+tau(4))-x(4); %Q_2 market clearing condition
F(21)=x(9)+x(10)-1; %Labor market clearing condition
F(22)=x(13)+x(14)-x(11)-x(12); %Capital market clearing condition

%Capital and Income Equalization
F(23)=(x(11)/x(9))-x(23); %Region 1 per capita capital k_1
F(24)=(x(12)/x(10))-x(24); %Region 2 per capita capital k_2
F(25)=((1+x(20)*x(23))/x(15))-((x(19)+x(20)*x(24))/x(16)); %%Regional real income equalization

end 