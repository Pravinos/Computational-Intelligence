% Linear PI controller
clear all;
close all;

% Initialize 
i = 0;
j = 0;
start = 0.1;
step = 0.1;
stop = 10;
sz = ((stop-start)/step) +1;
rise = NaN([sz sz]);
over = zeros([sz sz]);
t = 0 : 0.01 : 5;
u = ones(size(t));

% Gp(s)
numerator_p = 25;
denominator_p = [1 10.1 1];
gp = tf(numerator_p, denominator_p);

%Brute Force type method to determine the optimal combination of gains
%you can uncomment the code to visualize the best combinations in a 3D scatter plot).

%{
for Kp = start:step:stop
    i = i + 1;
    j = 0;
    for Kl = start:step:stop
        j = j+1;
        %Zero needs to be between 0.1 and 10
        if Kl/Kp >0.1 && Kl/Kp <10
            
            % Gc(s);
            numerator_c = [Kp Kl]; %[Kp, Kl]
            denominator_c = [1 0];
            gc = tf(numerator_c, denominator_c);
            
            
            % Open loop system
            sys_open_loop = series(gc, gp);
            
            
            % Closed loop system
            K = 1;
            sys_open_loop = K * sys_open_loop; 
            sys_closed_loop = feedback(sys_open_loop, 1, -1);
            
            %figure;
            
            %[y, t] = lsim(sys_closed_loop,u, t);
            
            info = stepinfo(sys_closed_loop);
            %over(i,j) = info.Overshoot;
            if info.Overshoot < 8 && info.RiseTime < 0.6  
                rise(i,j) = info.RiseTime;
            end

        end

    end
end

figure; 
sz =start:step:stop;
[sz1, sz2] = meshgrid(sz,sz);

scatter3(sz1, sz2, rise)

%}

% Gc(s)
numerator_c = [2.4 0.3]; %[Kp, Kl]
denominator_c = [1 0];
gc = tf(numerator_c, denominator_c);

% Open loop system
sys_open_loop = series(gc, gp);

% Create the root locus plot
figure;
rlocus(sys_open_loop)

% Closed loop system
K = 1;
sys_open_loop = K * sys_open_loop;
sys_closed_loop = feedback(sys_open_loop, 1, -1);

[y, t] = lsim(sys_closed_loop,u, t);

figure;
plot(t,y)
hold on;
plot(t,ones(size(y,1)), 'r')

info = stepinfo(sys_closed_loop);
rise_time = info.RiseTime;
overshoot = info.Overshoot;

fprintf('Gains selected: Kp = 2.4 , Kl = 0.3\n')
fprintf('Rise Time = %d, Overshoot = %d\n', rise_time, overshoot)


