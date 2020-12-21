%optimize main
clc
clear
load('base_track.mat')
load('optimize_track.mat')
load('map.mat')

%define which axis it is required to optimize 
optX = false
optY = false
optZ = true

%rotational steps
thetaX = 0.01;
thetaY = 0.01;
thetaZ = 0.001;
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

baseTrace = baseTrace(1000:2300,1:3);
optimizeTrace = optimizeTrace(1000:2300,1:3);

%DEBUG

baseTrace = [0,0,5;1,0,5;2,0,5]
optimizeTrace = [0,0,-5;-1,0,-5;-2,0,-5]


figure(1) % show original tracks 
hold on
pcshow(baseTrace,[0,0,1],'MarkerSize' ,10) %gnss track track (blue)
pcshow(optimizeTrace(:,1:3),[0,0,0],'MarkerSize' ,10) %lidar track track (black)
hold off


%%%%%%%%%%% OPTIMIZE Z
if optZ
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
figure(2)
plot(X(1:size(loss,2)),loss)
end % end of if optimize Z

if optY
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
figure(3)
plot(X(1:size(loss,2)),loss)

end % end of if optY

if optX
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
figure(4)
plot(X(1:size(loss,2)),loss)

end % end if optX


% Output optimum angles 
if optX ==false
   optimumAngle(1) = 0; 
end

if optY ==false
   optimumAngle(2) = 0; 
end

if optZ ==false
   optimumAngle(3) = 0; 
end

if optX
optimumAngle(1) = optimum_angleX;
end
if optY
optimumAngle(2) = optimum_angleY;
end
if optZ
optimumAngle(3) = optimum_angleZ;
end

%optimumAngle = wrapTo2Pi(optimumAngle)
save('optimumAngle.mat','optimumAngle');
