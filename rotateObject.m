function value = rotateObject(object,thetaX,thetaY,thetaZ)
%assume that received object is N by 3 matrix - transpose
object = transpose(object);
% rotation over Z axis for angle theta
rotZ = [cos(thetaZ) , -sin(thetaZ),0;
        sin(thetaZ), cos(thetaZ) , 0;
        0 ,           0 ,         1];
    
rotY = [cos(thetaY) ,0,sin(thetaY);
        0, 1 , 0;
       -sin(thetaY) ,           0 ,         cos(thetaY)];

rotX = [1,0,0;
    0,cos(thetaX),-sin(thetaX);
    0,sin(thetaX),cos(thetaX)];
   
% 3)apply transformation to the map

rotatedObject = rotX*rotY*rotZ*object;

value = transpose(rotatedObject);




end