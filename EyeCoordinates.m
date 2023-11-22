function [mouthx, mouthy, leftEye, rightEye] = EyeCoordinates(Eyes, Mouth)
   

    stats_Mouth = regionprops("table", Mouth, "Centroid", "MajorAxisLength", "MinorAxisLength");

    mouthCentroid = stats_Mouth.Centroid(1, :);
    mouthx = mouthCentroid(1);
    mouthy = round(mouthCentroid(2));
    
    %figure
    %imshow(Eyes)
    
    Eyes(mouthy-50:end, :) = 0;
    
    % Display the processed "Eyes" image
    %figure
    %imshow(Eyes);
    
    Rmin = 5;
    Rmax = 50;
    
    leftEye = [1,1];
    rightEye = [1,1];
    
    [centersDark, radiiDark] = imfindcircles(Eyes,[Rmin Rmax],'ObjectPolarity','dark', 'Sensitivity', 0.95);
    
    leftEye = centersDark(1,:) 
    rightEye = centersDark(2,:)
    
    
end
