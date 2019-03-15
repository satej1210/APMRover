%%%%%%%%%%%%%%% Track Vehicle Parameter %%%%%%%%%%%%%%%%%%%%%%%%%
b = 0.6;%0.5842 ; % [m] Effective Platform Width = Diagonal length
             % Actual Width = 0.3556 m
rNominal =  0.061679667; %[m] Nominal Wheel Radius
%
%Vmax = 0.43; %132/866.1417; % [m/s] Maximum speed of the vehicle
Vmax = 1.0329333; % @100%, moves 2.14 m in 4 sec 
Vmin = 0.1;
% wMax = Vmax/rNominal; % [rad/s] Maximum angular speed of wheels % NOT USED

rr = 0.95720524*rNominal; %% Effective vehicle right wheel 
rl = 1.0493058879*rNominal; %%  1%% Effective vehicle left wheel to represent inaccuracy in the vehicle

%%%%%%%%%%%%%%% Encoder Parameter %%%%%%%%%%%%%%%%%%%%%%%%%
eTick = 4384;%236.8852;%900; % 866.1417-905.5118; % [ticks/m] number of ticks per 1 m of vehicle translation % from 22-23 [ticks/inch]
TsampleEncoder = 1/10; %1/100; % 0.1 [s] Encoder sample time
%%
%%%%%%%%%%%%%%% Duty Cycle -> Speed - Conversion %%%%%%%%%%%%%%%%%%%%%%%%%
dcArray = [-100 -11 -10 0 10 11 100];
wArray  = [-Vmax, -Vmin, 0, 0,   0, Vmin, Vmax]./rNominal;


%%%%%%%%%%%%%%%%%% Initial Conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%
xIC = 0;
yIC = 0;
thetaIC = 0*(pi/180);