function correctedImg = GrayWorld(Im)

    %------------- STEP 1 ------------%
    % The brightness of all the pixels in the image is put in order from top to low, 
    % taking the top 5% of the pixels. If the number of pixels is more than enough 
    % (such as more than 1000), then calculate the respective average of these 
    % pixels component (R,G,B) and record as AR, AG, AB;

    Im = double(Im);

    % Separate channels
    R = Im(:,:,1);
    G = Im(:,:,2);
    B = Im(:,:,3);


    % VET INTE OM VI BEHÖVER DETTA? STÅR I RAPPORTEN ATT VI SKA BERÄKNA TOP 5%
    % MEN DEN GÖR JU LIKSOM INGENTING EGENTLIGEN?

    % % Calculate brightness (arithmetic mean)
    % brightness = (R + G + B) / 3;
    % 
    % % Find number of pixels in top 5%
    % totalPixels = numel(brightness);
    % numTopPixels = round(0.05 * totalPixels);
    % 
    % % Identify top 5% brightest pixels based on brightness
    % [~, indices] = sort(brightness(:), 'descend');
    % topPixelIndices = indices(1:numTopPixels);

    % Calculate the average of the top pixels for each channel
    % AR = mean(R(topPixelIndices));
    % AG = mean(G(topPixelIndices));
    % AB = mean(B(topPixelIndices));


    %--------------- STEP 2 ---------------%  
    % Calculate the value of max(AR, AG, and AB)/ min(AR, AG, and AB). 
    % If the value greatly deviates from 1, then determine the image has light interference.
    % Max = max([AR, AG, AB]);
    % Min = min([AR, AG, AB]);
    % 
    % Div = Max ./ Min; 
    % 
    % % Determine if there is light interference
    % if Div > 1.2 % Adjust this threshold as needed
    %     disp('The image has light interference.');
    % else
    %     disp('The image does not have significant light interference.');
    % end


    

    %--------------- STEP 1 ---------------%
    % Calculate the respective averages
    avgR = mean(R(:));
    avgG = mean(G(:));
    avgB = mean(B(:));

    avgGray = (avgR + avgG + avgB) / 3;

    %--------------- STEP 2 ---------------%
    % Calculate the adjustment factors
    aR = avgGray / avgR;
    aG = avgGray / avgG;
    aB = avgGray / avgB;

    %--------------- STEP 3 ---------------%
    % Adjust the values of R, G and B with the adjustment factors
    adjustedR = R * aR;
    adjustedG = G * aG;
    adjustedB = B * aB;

    % Check if the adjusted values exceed 255, if they do, set them to 255
    % Gives range of [0 255]
    adjustedR(adjustedR > 255) = 255;
    adjustedG(adjustedG > 255) = 255;
    adjustedB(adjustedB > 255) = 255;

    %--------------- STEP 4 ---------------%
    % Combine the adjusted channels to get the final adjusted image
    correctedImg = uint8(cat(3, adjustedR, adjustedG, adjustedB));
   
end


