function [output_image] = MouthMap(Im)

    % Convert color space and extract channels
    imgYCbCr = rgb2ycbcr(Im);
    Cr = double(imgYCbCr(:,:,3));
    Cb = double(imgYCbCr(:,:,2));

    % Parameters 
    numerator = 0.95 * sum(Cr.^2);
    denominator = sum(Cr./Cb);
    n = numerator / denominator;
    
    % Equation
    MouthMapC = Cr.^2 .* (Cr.^2 - (n .* (Cr./Cb))).^2;
    MouthMapC = im2double(MouthMapC);

    % Morphological operations
    se = strel('disk', 4);
    MouthMapC = imclose(MouthMapC, se);
    MouthMapC = imopen(MouthMapC, se);

    % Normalize
    MouthMapC = MouthMapC - min(MouthMapC(:));
    MouthMapC = MouthMapC / max(MouthMapC(:));

    % Create binary image 
    threshold = 0.5;
    binaryMouthMap = MouthMapC > threshold;

    output_image = im2double(binaryMouthMap);

    return
end
