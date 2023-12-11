%Fuzzy controller scenario 2 - Ramp functions
clear all;

% Open simulink model
open_system("Control_Scenario_2_2.mdl")

% Pick values for gains
Ke = 1;
Kd = 0.3;
K = 20;
        
% Set gain values into simulink model         
set_param('Control_Scenario_2_2/FLC/Kappa_e', 'Gain', 'Ke')
set_param('Control_Scenario_2_2/FLC/Kappa_d', 'Gain', 'Kd')
set_param('Control_Scenario_2_2/FLC/K', 'Gain', 'K')

% Simulate system
sim("Control_Scenario_2_2.mdl")

% Plot system response
figure;
plot(X.time,X.Data(:,1), 'r')
hold on;
plot(Y.time,Y.Data(:,2), 'b')
hold on;
title('FLC Response - Scenario 2.2')
ylabel('System Output');
xlabel('Time');





        