% Navigation Parameters
% if we want the estimation parameters identical to actual parameters
VmaxDR = Vmax; 
rNominalDR = rNominal;
bDR = 1*b;
eTickDR = eTick;
TsampleEncoderDR = TsampleEncoder;
TauEncoderDR = 0.001;
%%

%%%%%%%%%%%%%%%%%%% control parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1:speed, 2:angle
KP1=10; %20;    % 1 is velocity controller
KP2=7;%10;  %7 ->   % 2 is angle controller
KI1=0.05;%10;%0.3; %0.001; %0.001;%10;
KI2=0.05; %0.001; %0.001;%1; % 3 ->
KD1=1; %3; %0; %3; %0;%3;
KD2=1;% 3;%  %.5; %0; %0.5; %0;%0.5; %0.5 ->
Tsample = 1/10; %1/100; %1/10;   %sampling rate -> 0.01
Tmodel=Tsample;
Tau1 = 0.001;     %time constant of filter 1
Tau2 = 0.01;%0.1;       %time constant of filter 2

% wheel speed - DC conversion
wArrayC  = [-VmaxDR, -Vmin, 0,  Vmin, VmaxDR]./rNominalDR;
dcArrayC = [-100  -60 0  60  100];

%%%%%%%%%%%%%%%%%%% guidance parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%
rp1 =  0.4; % 1 -> [m] proximity circle to start slowing down
rp2 =  bDR;  % [m] radius of wayPoint proximity circle to switch to the next wayPoint
Vcom = 3*VmaxDR/4; % [m/s] used when constant speed is commanded

%%%%%%%%%%%%%%%%%% Way Points %%%%%%%%%%%%%%%%%%%%%%%%%%%
X_array  = [-2 -2 0 0];%[2 2 0 0 2 2 0 0 2 2 0 0];%[4 6 10]%[4 6 10] %[1 3];%[3 3 1.5 0 ]; 
Y_array  = [0 -3 -3 0];%[0 3 3 0 0 3 3 0 0 3 3 0];%[0 3 1 ]%[0 3 1 ]%[0 0];%[-2 0 -1.5 -0.25 ]; 
%%%%%%%%%%%%%%%%%%% guidance parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%
