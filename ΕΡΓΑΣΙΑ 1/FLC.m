%Fuzzy controller scenario 1
close all;
clear all;

reference = 50;

% Open simulink model
open_system("Control.mdl")

% Pick values for gains
Ke = 1;
Kd = 0.3;
K = 20;
        
% Set gain values into simulink model        
set_param('Control/FLC/Kappa_e', 'Gain', 'Ke')
set_param('Control/FLC/Kappa_d', 'Gain', 'Kd')
set_param('Control/FLC/K', 'Gain', 'K')

% Simulate system
sim("Control.mdl")

% Compute Overshoot
maxvalue = max(Y.Data(:,2));
overshoot = ((maxvalue - reference)/reference)*100;
        
% Compute Rise Time
targetY = reference*0.9;
[~, idx] = min(abs(Y.Data(:,2) - targetY));
rise = Y.time(idx);


% Plot system response
figure;
plot(Y.time,Y.Data(:,2), 'b')
hold on;
plot(Y.time, reference*ones(size(Y.time,1)), 'r')
title('FLC Response - Scenario 1')
ylabel('System Output');
xlabel('Time');

fprintf("Overshoot is: %d\n", overshoot);
fprintf("Rise Time is: %d\n", rise);
  



        