function F = model_k_r(x, gamma, alpha, alpha_t, delta, beta, a, d, t, r)

%x(1)=Q_tilde1
%x(2)=Q_tilde2
%x(3)=Q_1
%x(4)=Q_2
%x(5)=z_11
%x(6)=z_12
%x(7)=z_22
%x(8)=z_21
%x(9)=T_1
%x(10)=T_2

%x(11)=L_1
%x(12)=L_2
%x(13)=L_T1
%x(14)=L_t2

%x(15)=K_1
%x(16)=K_2
%x(17)=K_T1
%x(18)=K_T2

%x(19)=p_tilde1
%x(20)=p_tilde2
%x(21)=p_1
%x(22)=p_2
%x(23)=p_T1
%x(24)=p_T2
%x(25)=w_1
%x(26)=w_2

%x(27)=k_1
%x(28)=k_2

%Technology
F(1)=((0.5^(1-gamma))*(x(5)^gamma)+(0.5^(1-gamma))*(x(8)^gamma))^(1/gamma)-x(1); %Q_tilde1 production function
F(2)=((0.5^(1-gamma))*(x(7)^gamma)+(0.5^(1-gamma))*(x(6)^gamma))^(1/gamma)-x(2); %Q_tilde2 production function
F(3)=a(1)*(x(11)^(1-alpha))*(x(15)^alpha)-x(3); %Q_1 production function
F(4)=a(2)*(x(12)^(1-alpha))*(x(16)^alpha)-x(4); %Q_2 production function
F(5)=a(3)*(x(13)^(1-alpha_t))*(x(17)^alpha_t)-x(9); %T_1 production function
F(6)=a(3)*(x(14)^(1-alpha_t))*(x(18)^alpha_t)-x(10); %T_2 production function

%Producer Optimization
F(7)=(1-alpha)*x(21)*a(1)*((x(15)/x(11))^alpha)-x(25); %w_1 from Q_1
F(8)=(alpha)*x(21)*a(1)*((x(11)/x(15))^(1-alpha))-r; %r from Q_1
F(9)=(1-alpha)*x(22)*a(2)*((x(16)/x(12))^alpha)-x(26); %w_2 from Q_2
F(10)=(alpha)*x(22)*a(2)*((x(12)/x(16))^(1-alpha))-r; %r from Q_2

F(11)=(1-alpha_t)*x(23)*a(3)*((x(17)/x(13))^alpha_t)-x(25); %w_1 from T_1
F(12)=(alpha_t)*x(23)*a(3)*((x(13)/x(17))^(1-alpha_t))-r;%r from T_1
F(13)=(1-alpha_t)*x(24)*a(3)*((x(18)/x(14))^alpha_t)-x(26); %w_2 from T_2
F(14)=(alpha_t)*x(24)*a(3)*((x(14)/x(18))^(1-alpha_t))-r; %r rom T_2

F(15)=0.5*x(1)*(x(19)/(x(21)+d(1)*t*x(23)))^(1/(1-gamma))-x(5); %optimal demand for Z_11
F(16)=0.5*x(1)*(x(19)/(x(22)+d(4)*t*x(24)))^(1/(1-gamma))-x(8); %optimal demand for Z_21
F(17)=0.5*x(2)*(x(20)/(x(22)+d(3)*t*x(24)))^(1/(1-gamma))-x(7); %optimal demand for Z_22
F(18)=0.5*x(2)*(x(20)/(x(21)+d(2)*t*x(23)))^(1/(1-gamma))-x(6); %optimal demand for Z_12

%Consumer Optimization
F(19)=x(25)*(x(11)+x(13))+r*x(27)*(x(11)+x(13))-x(19)*x(1); %Region 1 aggregate budget constraint
F(20)=x(26)*(x(12)+x(14))+r*x(28)*(x(12)+x(14))-x(20)*x(2); %Region 2 aggregate budget constraint
F(21)=beta*(x(19)*(1-delta)+r)-x(19); %Region 1 Euler equation
F(22)=beta*(x(20)*(1-delta)+r)-x(20); %Region 2 Euler equation

%Market Clearing Conditions
F(23)=x(5)+x(6)-x(3); %Q_1 market clearing condition
F(24)=x(7)+x(8)-x(4); %Q_2 market clearing condition
F(25)=(x(5)*d(1)*t)+(x(6)*d(2)*t)-x(9); %T_1 market clearing condition 
F(26)=(x(7)*d(3)*t)+(x(8)*d(4)*t)-x(10); %T_2 market clearing condition
F(27)=x(11)+x(12)+x(13)+x(14)-1; %Labor market clearing condition
F(28)=x(15)+x(16)+x(17)+x(18)-x(27)*(x(11)+x(13))-x(28)*(x(12)+x(14));%Capital market clearing condition 

F(29)=((x(25)+r*x(27))/x(19))-((x(26)+r*x(28))/x(20));

end 

