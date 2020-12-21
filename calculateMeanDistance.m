
function value = calculateMeanDistance(baseTrace,optimizeTrace)

    % calculates mean distance between points of tracks
    
    for i=1:size(baseTrace,1)
        dist(i) = distance(baseTrace(i,:),optimizeTrace(i,:),'euclidean');
     
        
    end %end of for 
    value = mean(dist);

end 