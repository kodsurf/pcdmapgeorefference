%debug
clear
clc

baseTrace = [0,0,0; %blue
             1,0,0;
             2,0,0]
optimizeTrace = [0,0,0;
                1,1,0;
                2,2,0]


figure(1) % show original tracks 
hold on
pcshow(baseTrace,[0,0,1],'MarkerSize' ,10) %gnss track track (blue)
pcshow(optimizeTrace(:,1:3),[0,0,0],'MarkerSize' ,10) %lidar track track (black)
hold off


optAngleZ = optimizeZ(baseTrace,optimizeTrace,0.001)

optimizeTrace = rotateObject(optimizeTrace,0,0,optAngleZ )

figure(2) % show rotated tracks tracks 
hold on
pcshow(baseTrace,[0,0,1],'MarkerSize' ,10) %gnss track track (blue)
pcshow(optimizeTrace(:,1:3),[0,0,0],'MarkerSize' ,10) %lidar track track (black)
hold off

optAngleY = optimizeY(baseTrace,optimizeTrace,0.001)

optimizeTrace = rotateObject(optimizeTrace,0,optAngleY,0 )

figure(3) % show rotated tracks tracks 
hold on
pcshow(baseTrace,[0,0,1],'MarkerSize' ,10) %gnss track track (blue)
pcshow(optimizeTrace(:,1:3),[0,0,0],'MarkerSize' ,10) %lidar track track (black)
hold off



