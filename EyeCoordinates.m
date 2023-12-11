function [leftEye, rightEye] = EyeCoordinates(Eyes, Mouth)

    warning('off'); % Supress imfindcircles warning (looking for too small circles). 

    stats_Mouth = regionprops("table", Mouth, "Centroid", "MajorAxisLength", "MinorAxisLength"); % Find mouth

    if isempty(stats_Mouth) % Error handeling
        disp('Bilden är för dålig, ingen mun hittades');
    end

    mouthCentroid = stats_Mouth.Centroid(1, :);
    mouthy = round(mouthCentroid(2));
    
    Eyes(mouthy-50:end, :) = 0; % Remove mouth and area under mouth from eyes image. 
    
    Rmin = 5;
    Rmax = 50;
    
    [centersDark] = imfindcircles(Eyes,[Rmin Rmax],'ObjectPolarity','dark','Sensitivity', 0.90); % Find potential eyes
    
    if (length(centersDark) < 2) % Error handeling
        disp('Bilden är för dålig, inga ögon hittades'); 
    end 
      
    % Initial eyes
    leftEye = centersDark(1,:);
    rightEye = centersDark(2,:);
    
    x1 = rightEye(1,1);
    x2 = rightEye(1,2);
    y1 = leftEye(1,1);
    y2 = leftEye(1,2);
   
    slope = (rad2deg((y2 - y1) / (x2 - x1))); % Slope from the two eyes 
    
    % If the current eyes are in impossible postions in regard to eachother 
    if ((slope > 5) && (slope < -5) || (abs((rightEye(1,1) - leftEye(1,1))) < 80) || (abs((rightEye(1,1) - leftEye(1,1))) > 150) )

        for i = 1:length(centersDark) 
            if((leftEye(1,1) > 180)) % Left eye to much to the right? 
                
                    temp = leftEye(1,1); 
                    leftEye = centersDark(i,:);
                    y1 = leftEye(1,1); 
                    y2 = leftEye(1,2);
                    
                    if(((centersDark(i,1) == temp(1,1))) && (rightEye(1,1) < 180)) % If they are the same
                        rightEye = centersDark(i,:); 
                    end
            end 
        end 
        
            for i = 1:length(centersDark)
                
           % If the current eyes are in impossible postions in regard to eachother 
                if((abs((centersDark(i,1) - leftEye(1,1))) < 150) && ... 
                     (abs((centersDark(i,1) - leftEye(1,1))) > 80)  && ...
                     (i ~= length(centersDark)) && ((centersDark(i,1) ~= leftEye(1,1)))) 

                        rightEye = centersDark(i,:); % Update right eye to next candidate 

           % Recalcualte slope to test the new eyes in regard to eachother 
                        x1 = rightEye(1,1); 
                        x2 = rightEye(1,2); 
                        slope = abs(rad2deg((y2 - y1) / (x2 - x1)));
                        
                        if ((slope < 10) && (slope > -10) && (abs((rightEye(1,1) - leftEye(1,1))) < 130))
                           
                            break;
                            
                        end
                 end
            end
    end 
    
    % Check if the left eye really is the left eye
    if (rightEye(1,1) < leftEye(1,1))
        temp = leftEye; 
        leftEye = rightEye;
        rightEye = temp;
    end
   
       warning('on');
end
