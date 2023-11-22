function [mouthx, mouthy, leftEye, rightEye] = EyeCoordinates(Eyes, Mouth)
   
    stats_Mouth = regionprops("table", Mouth, "Centroid", "MajorAxisLength", "MinorAxisLength");

    mouthCentroid = stats_Mouth.Centroid(1, :);
    mouthx = mouthCentroid(1);
    mouthy = round(mouthCentroid(2));
    
    Eyes(mouthy-50:end, :) = 0;
    
    Rmin = 5;
    Rmax = 50;
    
    [centersDark, ~] = imfindcircles(Eyes,[Rmin Rmax],'ObjectPolarity','dark','Sensitivity', 0.95);
      
    leftEye = centersDark(1,:);
    rightEye = centersDark(2,:);
    
    if (centersDark(1,1) > centersDark(2,1)) %Om vänster ögat är det högra
        leftEye = centersDark(2,:);
        rightEye = centersDark(1,:);
    else
        leftEye = centersDark(1,:);
        rightEye = centersDark(2,:);
    end
    
    % Kontrollera med vinkeln om vi ens behver ändra något öga. 
    
    
    for i = 2:length(centersDark) - 1
        
         if((abs((centersDark(i,1) - leftEye(1,1))) < 150) && ... 
             (abs((centersDark(i,1) - leftEye(1,1))) > 120)  && ...
             (i ~= length(centersDark))) 

                rightEye = centersDark(i,:); 
                
         end
    end
    abs((rightEye(1,1) - leftEye(1,1)))
end
