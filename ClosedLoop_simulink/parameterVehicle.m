%%%%%%%%%%%%%%% Track Vehicle Parameter %%%%%%%%%%%%%%%%%%%%%%%%%
b = 0.32;%0.5842 ; % [m] Effective Platform Width = Diagonal length
             % Actual Width = 0.3556 m
rNominal =  0.061679667; %[m] Nominal Wheel Radius
%
%Vmax = 0.43; %132/866.1417; % [m/s] Maximum speed of the vehicle
Vmax = 0.705; % @100%, moves 2.14 m in 4 sec 
Vmin = 0.45;
% wMax = Vmax/rNominal; % [rad/s] Maximum angular speed of wheels % NOT USED

rr = 1.00*rNominal; %% Effective vehicle right wheel 
rl = 0.87*rNominal; %%  1%% Effective vehicle left wheel to represent inaccuracy in the vehicle

%%%%%%%%%%%%%%% Encoder Parameter %%%%%%%%%%%%%%%%%%%%%%%%%
eTick = 4300;%236.8852;%900; % 866.1417-905.5118; % [ticks/m] number of ticks per 1 m of vehicle translation % from 22-23 [ticks/inch]
TsampleEncoder = 1/10; %1/100; % 0.1 [s] Encoder sample time
%%
%%%%%%%%%%%%%%% Duty Cycle -> Speed - Conversion %%%%%%%%%%%%%%%%%%%%%%%%%
wArrayL  = [-1.622403101
-1.542170543
-1.240310078
-1.065891473
-0.864108527
-0.703565891
-0.619767442
-0.37620155
0.356666667
0.459224806
0.593178295
0.667674419
0.818372093
1.022325581
1.158294574
1.21744186
1.449379845];
dcArrayL = [-100
-90
-80
-70
-60
-50
-45
-30
30
35
45
50
60
70
80
90
100
];

wArrayR  = [-1.288449612
-1.116589147
-1.051782946
-0.925193798
-0.761782946
-0.634806202
-0.564883721
-0.36503876
0.35875969
0.421007752
0.573023256
0.626744186
0.780542636
0.946744186
1.066744186
1.151550388
1.311627907
]./rNominal;
dcArrayR = [-100
-90
-80
-70
-60
-50
-45
-30
30
35
45
50
60
70
80
90
100
];

%%%%%%%%%%%%%%%%%% Initial Conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%
xIC = 0;
yIC = 0;
thetaIC = 0*(pi/180);

