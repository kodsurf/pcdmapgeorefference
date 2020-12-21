clc
clear

% Initializes ros node. Subscribes to gnss possition and lidar localization
% topics. Stores the data as arrays.
% Visualization is implemented using plot_track_on_map.m script


%initialize matlab node
node = robotics.ros.Node('read_gnss');
visualize = true
%GNSSorigin = [537998.4050373654,6584390.981572637,24.358292735042795]
GNSSorigin = [0,0,0]

% subsribe to gnss message topic with node
%define proper message type

%sub = robotics.ros.Subscriber(node,'/nmea_sentence','nmea_msgs/Sentence');

%subscribe to gnss messages ( local estonian cartesian)
subGnss = robotics.ros.Subscriber (node, '/gnss_pose','geometry_msgs/PoseStamped');
%subGnss = robotics.ros.Subscriber (node, '/gnss2map_offset','geometry_msgs/PoseStamped');
pause(1);
% subscribe to localization position
subLocalizer = robotics.ros.Subscriber (node, '/ndt_pose','geometry_msgs/PoseStamped');
pause(1);

gnss = []; %arrays will contain possitions read by gnss and localizer
localizer =[];
counter = 0;
%r = rosrate(1);
r = robotics.ros.Rate(node,1);
figure(1)
hold on
while (true)
hold on
msgGnss = receive(subGnss,10); % receive messages from subGnss
msgLocalizer = receive(subLocalizer,10); % receive messages from subLocalizer  10 seconds timeout

%gnss(counter,1) = msgGnss.Pose.Position.X


temp(1,1) = msgGnss.Pose.Position.X;
temp(1,2) = msgGnss.Pose.Position.Y;
temp(1,3) = msgGnss.Pose.Position.Z;
temp(1,4) = msgGnss.Pose.Orientation.X;
temp(1,5) = msgGnss.Pose.Orientation.Y;
temp(1,6) = msgGnss.Pose.Orientation.Z;
temp(1,7) = msgGnss.Pose.Orientation.W;

temp(1,1:3) = temp(1,1:3) - GNSSorigin;

gnss = [gnss;temp];


temp(1,1) = msgLocalizer.Pose.Position.X;
temp(1,2) = msgLocalizer.Pose.Position.Y;
temp(1,3) = msgLocalizer.Pose.Position.Z;
temp(1,4) = msgLocalizer.Pose.Orientation.X;
temp(1,5) = msgLocalizer.Pose.Orientation.Y;
temp(1,6) = msgLocalizer.Pose.Orientation.Z;
temp(1,7) = msgLocalizer.Pose.Orientation.W;

localizer = [localizer;temp];

if visualize 
pcshow(gnss(:,1:3),[0,0,1],'MarkerSize' ,100) %gnss track track (blue)
pcshow(localizer(:,1:3),[0,0,0],'MarkerSize' ,100) %lidar track track (black)
    
    
end

counter = counter +1
waitfor(r);
end % end of main while
hold off

%save gnss and localizer tracks
save('localizer_track.mat','localizer');
%save('gnss_track.mat','gnss');

clear('node') % close the node 
rosshutdown % shut down matlab node

% transform a gnss received coordinates 
%GNSSorigin = [537998.4050373654,6584390.981572637,24.358292735042795]
%gnss(:,1:3) = gnss(:,1:3) - GNSSorigin;
save('gnss_track.mat','gnss')

% plot tracks
figure(2)
%scatter3(gnss(:,1),gnss(:,2),gnss(:,3)) % gnss track
pcshow(gnss(:,1:3),[0,0,1],'MarkerSize' ,100) %gnss track track (blue)


figure(3) 
%scatter3(localizer(:,1),localizer(:,2),localizer(:,3))
pcshow(localizer(:,1:3),[0,0,0],'MarkerSize' ,100) %lidar track track (black)





