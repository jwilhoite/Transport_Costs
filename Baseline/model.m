function F = model(x, gamma, a, d, t)

%x(1) - Q_tilde1
%x(2) - Q_tilde2
%x(3) - Q_1
%x(4) - Q_2
%x(5) - Z_11
%x(6) - Z_12
%x(7) - Z_22
%x(8) - Z_21
%x(9) - T_1
%x(10) - T_2

%x(11) - L_1
%x(12) - L_2
%x(13) - L_T1
%x(14) - L_T2

%x(15) - p_tilde1
%x(16) - p_tilde2
%x(17) - p_1
%x(18) - p_2
%x(19) - p_T1
%x(20) - p_T2
%x(21) - w_2

%Technology 
F(1) = (((0.5)^(1-gamma))*x(5)^(gamma)+((0.5)^(1-gamma))*x(8)^(gamma))^(1/gamma)-x(1); %Q_tilde1 production function
F(2) = (((0.5)^(1-gamma))*x(7)^(gamma)+((0.5)^(1-gamma))*x(6)^(gamma))^(1/gamma)-x(2); %Q_tilde2 production function
F(3) = a(1)*x(11)-x(3); %Q_1 production function
F(4) = a(2)*x(12)-x(4); %Q_2 production function
F(5) = a(3)*x(13)-x(9); %T_1 production function
F(6) = a(3)*x(14)-x(10); %T_2 production function

%Consumer optimization
F(7) = ((x(11)+x(13))/x(15))-x(1); %aggregate consumption of Q_tilde1 
F(8) = (x(21)*(x(12)+x(14))/x(16))-x(2); %aggregate consumption of Q_tilde2

%Producer optimization
F(9) = (1/a(1))-x(17); %p_1, prices for commodity Q_1
F(10) = (x(21)/a(2))-x(18); %p_2, prices for commodity Q_2
F(11) = (1/a(3))-x(19); %p_T1, price for T_1 transport services
F(12) = (x(21)/a(3))-x(20); %p_T2, price for T_2 transport services
F(13) = 0.5*x(1)*(x(15)/(x(17)+d(1)*t*x(19)))^(1/(1-gamma))-x(5); %optimal demand for Z_11
F(14) = 0.5*x(1)*(x(15)/(x(18)+d(4)*t*x(20)))^(1/(1-gamma))-x(8); %optimal demand for Z_21
F(15) = 0.5*x(2)*(x(16)/(x(18)+d(3)*t*x(20)))^(1/(1-gamma))-x(7); %optimal demand for Z_22
F(16) = 0.5*x(2)*(x(16)/(x(17)+d(2)*t*x(19)))^(1/(1-gamma))-x(6); %optimal demand for Z_12

%Market clearing conditions
F(17) = x(5)+x(6)-x(3); %market clearing condition for Q_1
F(18) = x(7)+x(8)-x(4); %market clearing condition for Q_2
F(19) = (x(5)*d(1)*t)+(x(6)*d(2)*t)-x(9); %market clearing condition for T_1
F(20) = (x(7)*d(3)*t)+(x(8)*d(4)*t)-x(10); %market clearing condition for T_2
F(21) = x(11)+x(12)+x(13)+x(14)-10; %market clearing condition for labor L_bar
F(22) = (1/x(15))-(x(21)/x(16)); %real wage equalization 
end 















