function value = optimizeX(baseTrace,optimizeTrace,thetaX)
%1) calculate number of iterations
iterations = int16(2*pi/thetaX);
iterations = iterations*1.2;



%  2)Calculate mean distances manually for first time
loss(1) = calculateMeanDistance(baseTrace,optimizeTrace)
% initialize rotation angle for the first time
thetaRot = thetaX
totalRotation =0;


% Main loop Z axis optimisation

for i=1:iterations-1
    % rotate for given angle
    optimizeTrace = rotateObject(optimizeTrace,0,thetaRot,0);
    %calculate mean distances
    loss(i+1) =  calculateMeanDistance(baseTrace,optimizeTrace);
    
    % 
    dLoss(i) = loss(i+1) - loss(i);
    totalRotation = totalRotation+thetaRot;
    
    
    

    


end %end of main loop

% X axis for plotting. X step is equal to step
X = linspace(0,totalRotation,iterations);

 [m,i] = min(loss)
 optimum_angleX = i*thetaX
%figure()
%plot(X(1:size(loss,2)),loss)

value = optimum_angleX;
end% end of function