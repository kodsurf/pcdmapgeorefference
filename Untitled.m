%optimize main
clc
clear
load('base_track.mat')
load('optimize_track.mat')
load('map.mat')

%rotational steps
thetaX = 0.01;
thetaY = 0.01;
thetaZ = 0.01;
% Number of iterations
% calculate number of iterations
iterationsZ = int16(2*pi/thetaZ);
iterationsZ = iterationsZ*1.2;

iterationsY = int16(2*pi/thetaY);
iterationsY = iterationsY*1.2;

iterationsX = int16(2*pi/thetaX);
iterationsX = iterationsX*1.2;

% Maximum step
%maxAngleStep = 0.003; % RAD

baseTrace = baseTrace(1:1500,1:3);
optimizeTrace = optimizeTrace(1:1500,1:3);


%%%%%%%%%%% OPTIMIZE Z

%  Calculate mean distances manually for first time
loss(1) = calculateMeanDistance(baseTrace,optimizeTrace)
% initialize rotation angle for the first time
thetaRot = thetaZ
totalRotation(3) =0;

% Main loop Z axis optimisation

for i=1:iterationsZ-1
    % rotate for given angle
    optimizeTrace = rotateObject(optimizeTrace,0,0,thetaRot);
    %calculate mean distances
    loss(i+1) =  calculateMeanDistance(baseTrace,optimizeTrace);
    
    % 
    dLoss(i) = loss(i+1) - loss(i);
    totalRotation(3) = totalRotation(3)+thetaRot;
    
    

    


end %end of main loop

% X axis for plotting. X step is equal to step
X = linspace(0,totalRotation(3),iterationsZ);

 [m,i] = min(loss)
 optimum_angleZ = i*thetaZ
figure(1)
plot(X(1:size(loss,2)),loss)



%Optimize Y%%%%%%%%%%%%%%%%%%%%%%%%%%
loss = [];
dLoss = [];


%  Calculate mean distances manually for first time
loss(1) = calculateMeanDistance(baseTrace,optimizeTrace)
% initialize rotation angle for the first time
thetaRot = thetaY
totalRotation(2) =0;



for i=1:iterationsY-1
    % rotate for given angle
    optimizeTrace = rotateObject(optimizeTrace,0,thetaRot,0);
    %calculate mean distances
    loss(i+1) =  calculateMeanDistance(baseTrace,optimizeTrace);
    
    % 
    dLoss(i) = loss(i+1) - loss(i);
    totalRotation(2) = totalRotation(2)+thetaRot;
    
    

    


end %end of main loop

% X axis for plotting. X step is equal to step
X = linspace(0,totalRotation(2),iterationsY);

 [m,i] = min(loss)
 optimum_angleY = i*thetaY
figure(2)
plot(X(1:size(loss,2)),loss)




%%%%%%%%%%%% OPTIMIZE X



%Optimize Y%%%%%%%%%%%%%%%%%%%%%%%%%%
loss = [];
dLoss = [];


%  Calculate mean distances manually for first time
loss(1) = calculateMeanDistance(baseTrace,optimizeTrace)
% initialize rotation angle for the first time
thetaRot = thetaX
totalRotation(1) =0;



for i=1:iterationsX-1
    % rotate for given angle
    optimizeTrace = rotateObject(optimizeTrace,thetaRot,0,0);
    %calculate mean distances
    loss(i+1) =  calculateMeanDistance(baseTrace,optimizeTrace);
    
    % 
    dLoss(i) = loss(i+1) - loss(i);
    totalRotation(1) = totalRotation(1)+thetaRot;
    
    

    


end %end of main loop

% X axis for plotting. X step is equal to step
X = linspace(0,totalRotation(1),iterationsX);

 [m,i] = min(loss)
 optimum_angleX = i*thetaX
figure(3)
plot(X(1:size(loss,2)),loss)




% Output optimum angles 

optimumAngle(1) = optimum_angleX;
optimumAngle(2) = optimum_angleY;
optimumAngle(3) = optimum_angleZ;

optimumAngle = wrapTo2Pi(optimumAngle)
