function F = model_k(x, gamma, alpha, alpha_t, delta, beta, a, d, t)

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

%x(15)=K_hat1
%x(16)=K_hat2
%x(17)=K_1
%x(18)=K_2
%x(19)=K_T1
%x(20)=K_T2

%x(21)=p_tilde1
%x(22)=p_tilde2
%x(23)=p_1
%x(24)=p_2
%x(25)=p_T1
%x(26)=p_T2
%x(27)=w_2
%x(28)=r

%x(29)=C_tilde1
%x(30)=C_tilde2

%x(31)=k_1
%x(32)=k_2

%Technology
F(1)=((0.5^(1-gamma))*(x(5)^gamma)+(0.5^(1-gamma))*(x(8)^gamma))^(1/gamma)-x(1);
F(2)=((0.5^(1-gamma))*(x(7)^gamma)+(0.5^(1-gamma))*(x(6)^gamma))^(1/gamma)-x(2);
F(3)=a(1)*(x(11)^(1-alpha))*(x(17)^alpha)-x(3);
F(4)=a(2)*(x(12)^(1-alpha))*(x(18)^alpha)-x(4);
F(5)=a(3)*(x(13)^(1-alpha_t))*(x(19)^alpha_t)-x(9);
F(6)=a(3)*(x(14)^(1-alpha_t))*(x(20)^alpha_t)-x(10);

%Producer Optimization
F(7)=((1/a(1))*(x(28)*((1-alpha)/alpha))^alpha)*x(3)-x(11);
F(8)=((1/a(1))*((1/x(28))*(alpha/(1-alpha)))^(1-alpha))*x(3)-x(17);
F(9)=((1/a(2))*((x(28)/x(27))*((1-alpha)/alpha))^alpha)*x(4)-x(12);
F(10)=((1/a(2))*((x(27)/x(28))*(alpha/(1-alpha)))^(1-alpha))*x(4)-x(18);

F(11)=((1/a(3))*(x(28)*((1-alpha_t)/alpha_t))^(alpha_t))*x(9)-x(13);
F(12)=((1/a(3))*((1/x(28))*(alpha_t/(1-alpha_t)))^(1-alpha_t))*x(9)-x(19);
F(13)=((1/a(3))*((x(28)/x(27))*((1-alpha_t)/alpha_t))^alpha_t)*x(10)-x(14);
F(14)=((1/a(3))*((x(27)/x(28))*(alpha_t/(1-alpha_t)))^(1-alpha_t))*x(10)-x(20);

F(15)=0.5*x(1)*(x(21)/(x(23)+d(1)*t*x(25)))^(1/(1-gamma))-x(5);
F(16)=0.5*x(1)*(x(21)/(x(24)+d(4)*t*x(26)))^(1/(1-gamma))-x(8);
F(17)=0.5*x(2)*(x(22)/(x(24)+d(3)*t*x(26)))^(1/(1-gamma))-x(7);
F(18)=0.5*x(2)*(x(22)/(x(23)+d(2)*t*x(25)))^(1/(1-gamma))-x(6);

%Consumer Optimization
F(19)=x(11)+x(13)+(x(28)-delta*x(21))*x(15)-x(21)*x(29);
F(20)=x(27)*(x(12)+x(14))+(x(28)-delta*x(22))*x(16)-x(22)*x(30);
F(21)=beta*(x(21)*(1-delta)+x(28))-x(21);
F(22)=beta*(x(22)*(1-delta)+x(28))-x(22);

%Market Clearing Conditions
F(23)=x(29)+delta*x(15)-x(1);
F(24)=x(30)+delta*x(16)-x(2);
F(25)=x(5)+x(6)-x(3);
F(26)=x(7)+x(8)-x(4);
F(27)=(x(5)*d(1)*t)+(x(6)*d(2)*t)-x(9);
F(28)=(x(7)*d(3)*t)+(x(8)*d(4)*t)-x(10);
F(29)=x(11)+x(12)+x(13)+x(14)-1;
F(30)=x(17)+x(18)+x(19)+x(20)-x(15)-x(16);

%Capital and Income Equalization
F(31)=(x(15)/(x(11)+x(13)))-x(31);
F(32)=(x(16)/(x(12)+x(14)))-x(32);
F(33)=((1+x(28)*x(31))/x(21))-((x(27)+x(28)*x(32))/x(22));

end 
