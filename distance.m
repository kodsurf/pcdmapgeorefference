%1) Define general distance function

function value=distance(point1,point2,type)

%point 1 and 2 are vectors with arbitrary dimentions. Both vectors must
%have the same dimentionality



dimentions = size(point1);
summ = 0;
%%%%%%%%%%%%%%%%%
if type=='euclidean'
    
    for i=1:dimentions(1,2)
        
       summ = summ +(point2(1,i)-point1(1,i))^2;
        
    end
    
   value = sqrt(summ);
   return
   
    
end
%%%%%%%%%%%%%%%%%
if type =='manhattan'
    
    
    for i=1:dimentions(1,2)
        
       summ = summ +abs(point2(1,i)-point1(1,i));
        
    end
    
   value = summ;
   return
    
    
    
end

%%%%%%%%%%%%%%%%

if type == 'Chebyshev'
    
    compare = 0;
    
    for i=1:dimentions(1,2)
        
        summ = abs(point2(1,i)-point1(1,i));
        if summ > compare
           compare = summ;
        end
        
        
     end
    
  value = compare;
  return
    
    
end

%%%%%%%%%%%%%%%%%%%%%

if type =='Canberra'
    
end
%%%%%%%%%%%%%%%%%

if type == 'Mahalanobis'
end
%%%%%%%%%%%%%%%%%
if type == 'Cosine'
    
end
%%%%%%%%%%%%%%%%%



end