function [mouthx, mouthy, leftEye, rightEye] = EyeCoordinates(Eyes, Mouth)
   

    stats_Mouth = regionprops("table", Mouth, "Centroid", "MajorAxisLength", "MinorAxisLength");

    mouthCentroid = stats_Mouth.Centroid(1, :);
    mouthx = mouthCentroid(1);
    mouthy = mouthCentroid(2);
    
    Rmin = 5;
    Rmax = 50;
    
    leftEye = [1,1];
    rightEye = [1,1];
    
    xled = Eyes(:,1)
    
    [centersDark, radiiDark] = imfindcircles(Eyes,[Rmin Rmax],'ObjectPolarity','dark', 'Sensitivity', 0.90);
    
    centersDark
    
    leftEye = centersDark(1,:); 
    rightEye = centersDark(2,:);
    
    %for i = 1:length(centersDark) - 1
    
     %   for j = 2:length(centersDark)
            
      %      if((abs((centersDark(i,1) - (centersDark(j,1)))) < 100) && (abs((centersDark(i,1) - (centersDark(j,1)))) > 40))
         
       %         if ((centersDark(i,2) < (mouthy-10)) && (centersDark(j,2) < (mouthy-10)))
           
        %            if (abs(centersDark(i,2) - centersDark(j,2)) < 15) % Y
                
                    
         %               leftEye = centersDark(i,:); 
                       % rightEye = centersDark(j,:); 
                          
                  
                
           %         end 
                
            %    end 
        
            %end
        
       % end
    
    %end
    
end
