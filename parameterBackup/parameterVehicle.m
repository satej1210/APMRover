%%%%%%%%%%%%%%% Track Vehicle Parameter %%%%%%%%%%%%%%%%%%%%%%%%%
b = 0.6;%0.5842 ; % [m] Effective Platform Width = Diagonal length
             % Actual Width = 0.3556 m
rNominal =  0.061679667; %[m] Nominal Wheel Radius
%
%Vmax = 0.43; %132/866.1417; % [m/s] Maximum speed of the vehicle
Vmax = 0.5; % @100%, moves 2.14 m in 4 sec 
Vmin = 0.1;
% wMax = Vmax/rNominal; % [rad/s] Maximum angular speed of wheels % NOT USED

rr = 0.95720524*rNominal; %% Effective vehicle right wheel 
rl = 1.0493058879*rNominal; %%  1%% Effective vehicle left wheel to represent inaccuracy in the vehicle

%%%%%%%%%%%%%%% Encoder Parameter %%%%%%%%%%%%%%%%%%%%%%%%%
eTick = 4384;%236.8852;%900; % 866.1417-905.5118; % [ticks/m] number of ticks per 1 m of vehicle translation % from 22-23 [ticks/inch]
TsampleEncoder = 1/10; %1/100; % 0.1 [s] Encoder sample time
%%
%%%%%%%%%%%%%%% Duty Cycle -> Speed - Conversion %%%%%%%%%%%%%%%%%%%%%%%%%
wArrayC  = [-1.077021774	-1.179507097	-0.790238407	-0.604574453	-0.321661344	0	0	0	0	0	0	0	0.367944402	0.657756939	0.900420859	1.181991507	1.404768731]./rNominalDR;
dcArrayC = [-90 -70 -50 -30 -20 -10 -5 0 5 10 20 30 50 70 90 100];


%%%%%%%%%%%%%%%%%% Initial Conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%
xIC = 0;
yIC = 0;
thetaIC = 0*(pi/180);