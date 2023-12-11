function outImg = ColorCorrection(inImg)
    
    % Extract color channels
    red = double(inImg(:,:,1));
    green = double(inImg(:,:,2));
    blue = double(inImg(:,:,3));

    % Find the max values in each channel
    rMax = max(red(:));
    gMax = max(green(:));
    bMax = max(blue(:));

    % Normalize each channel using the max values
    red = red / rMax;
    green = green / gMax;
    blue = blue / bMax;

    % Combine the normalized channels
    outImg(:,:,1) = uint8(255 * red);
    outImg(:,:,2) = uint8(255 * green);
    outImg(:,:,3) = uint8(255 * blue);
    
end
