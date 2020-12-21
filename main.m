%MAIN
clear
clc

load('base_track.mat')
load('optimize_track.mat')
load('map.mat')

baseTrace = baseTrace(:,1:3);
optimizeTrace = optimizeTrace(:,1:3);

Xstep = 0.01;
Ystep = 0.01;
Zstep = 0.01;


figure(1) % show original tracks 
title('ORIGINAL GNSS AND LIDAR TRACKS')
hold on
pcshow(baseTrace,[0,0,1],'MarkerSize' ,50) %gnss track track (blue)
pcshow(optimizeTrace(:,1:3),[0,0,0],'MarkerSize' ,50) %lidar track track (black)
hold off


optAngleZ = optimizeZ(baseTrace,optimizeTrace,Zstep);
optAngleZ = wrapTo2Pi(optAngleZ);

optimizeTrace = rotateObject(optimizeTrace,0,0,optAngleZ );

figure(2) % show rotated tracks tracks 
title('AFTER Z AXIS OPTIMIZATION')
hold on
pcshow(baseTrace,[0,0,1],'MarkerSize' ,50) %gnss track track (blue)
pcshow(optimizeTrace(:,1:3),[0,0,0],'MarkerSize' ,50) %lidar track track (black)
hold off

optAngleY = optimizeY(baseTrace,optimizeTrace,Ystep);
optAngleY = wrapTo2Pi(optAngleY);

optimizeTrace = rotateObject(optimizeTrace,0,optAngleY,0 );

figure(3) % show rotated tracks tracks 
title('AFTER Z and Y AXIS OPTIMIZATION')
hold on
pcshow(baseTrace,[0,0,1],'MarkerSize' ,50) %gnss track track (blue)
pcshow(optimizeTrace(:,1:3),[0,0,0],'MarkerSize' ,10) %lidar track track (black)
hold off



optAngleX = optimizeX(baseTrace,optimizeTrace,Xstep);
optAngleX = wrapTo2Pi(optAngleX);
optimizeTrace = rotateObject(optimizeTrace,optAngleX,0,0 );


figure(4) % show rotated tracks tracks 
title('AFTER Z and Y and X AXIS OPTIMIZATION')
hold on
pcshow(baseTrace,[0,0,1],'MarkerSize' ,10) %gnss track track (blue)
pcshow(optimizeTrace(:,1:3),[0,0,0],'MarkerSize' ,10) %lidar track track (black)
hold off



figure(5) % Rotate map and plot everything 
hold on
title('Projection on rotated map')
map = rotateObject(map,0,optAngleY,optAngleZ);
pcshow(map)
pcshow(baseTrace,[0,0,1],'MarkerSize' ,10) %gnss track track (blue)
pcshow(optimizeTrace(:,1:3),[0,0,0],'MarkerSize' ,10) %lidar track track (black)
hold off


%display total rotation angle for optimization

optimal_rotation=[optAngleX,optAngleY,optAngleZ]


