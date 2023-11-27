function [leftEye, rightEye] = EyeCoordinates(Eyes, Mouth)
   
    stats_Mouth = regionprops("table", Mouth, "Centroid", "MajorAxisLength", "MinorAxisLength");

    mouthCentroid = stats_Mouth.Centroid(1, :);
    mouthx = mouthCentroid(1);
    mouthy = round(mouthCentroid(2));
    
    Eyes(mouthy-50:end, :) = 0;
    
    Rmin = 5;
    Rmax = 50;
    
    [centersDark] = imfindcircles(Eyes,[Rmin Rmax],'ObjectPolarity','dark','Sensitivity', 0.90); %#OK
      
    leftEye = centersDark(1,:);
    rightEye = centersDark(2,:);
    
    if (centersDark(1,1) > centersDark(2,1)) %Om vänster ögat är det högra
        leftEye = centersDark(2,:);
        rightEye = centersDark(1,:);
    end
    
    % Kontrollera med vinkeln om vi ens behver ändra något öga. 
    
    x1 = rightEye(1,1); 
    x2 = rightEye(1,2); 
    y1 = leftEye(1,1); 
    y2 = leftEye(1,2); 
  
    slope = (y2 - y1) / (x2 - x1);

    desired_angle = 3;

    theta = deg2rad(desired_angle);
    desired_slope = tan(theta);

    angle_tolerance = 3; % Set your desired angle tolerance

    is_level = abs(slope - desired_slope) <= tand(angle_tolerance);
    
    if ((~is_level) || (abs((rightEye(1,1) - leftEye(1,1))) < 100))

            for i = 2:length(centersDark) - 1

                 if((abs((centersDark(i,1) - leftEye(1,1))) < 150) && ... 
                     (abs((centersDark(i,1) - leftEye(1,1))) > 120)  && ...
                     (i ~= length(centersDark))) 

                        rightEye = centersDark(i,:); 

                        x1 = rightEye(1,1); 
                        x2 = rightEye(1,2); 
                        slope = (y2 - y1) / (x2 - x1);

                        is_level = abs(slope - desired_slope) < eps;
                        
                        if ((~is_level) || (abs((rightEye(1,1) - leftEye(1,1))) < 100))
                            
                            break;
                            
                        end
                        

                 end
            end
    end 
    
   
end
