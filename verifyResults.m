% Verify results
clc
clear
load('base_track.mat')
load('optimize_track.mat')
load('map.mat')
load('optimumAngle.mat')
baseTrace = baseTrace(:,1:3);
optimizeTrace = optimizeTrace(:,1:3);

figure(1) % original map with base trace
hold on
%pcshow(map)
pcshow(baseTrace,[0,0,1],'MarkerSize' ,10) %gnss track track (blue)
pcshow(optimizeTrace(:,1:3),[0,0,0],'MarkerSize' ,10) %lidar track track (black)

% rotate map and optimizationTrace for calculated angles
map = rotateObject(map,optimumAngle(1),optimumAngle(2),optimumAngle(3));
optimizeTrace = rotateObject(optimizeTrace,optimumAngle(1),optimumAngle(2),optimumAngle(3));

% plot everything after rotation

figure(2)
hold on
%pcshow(map)
pcshow(baseTrace,[0,0,1],'MarkerSize' ,10) %base track  (blue)
pcshow(optimizeTrace(:,1:3),[0,0,0],'MarkerSize' ,10) %lidar track track (black)