function [output_image] = MouthMap(Im)
    % Convert the image to YCbCr color space
    imgYCbCr = rgb2ycbcr(Im);

    % Extract the Cr and Cb channels
    Cr = double(imgYCbCr(:,:,3));
    Cb = double(imgYCbCr(:,:,2));

    % Calculate the first mouth map
    numerator = 0.95 * sum(Cr.^2);
    denominator = sum(Cr./Cb);
    n = numerator / denominator;
    MouthMapC = Cr.^2 .* (Cr.^2 - (n .* (Cr./Cb))).^2;
    MouthMapC = im2double(MouthMapC);

    % Apply morphological operations to enhance the mouth map
    se = strel('disk', 4);
    MouthMapC = imclose(MouthMapC, se);
    MouthMapC = imopen(MouthMapC, se);

    % Normalize the mouth map
    MouthMapC = MouthMapC - min(MouthMapC(:));
    MouthMapC = MouthMapC / max(MouthMapC(:));

    % Apply thresholding to create a binary mouth map
    threshold = 0.5; % Adjust the threshold as needed
    binaryMouthMap = MouthMapC > threshold;

    % Output the binary mouth map
    output_image = im2double(binaryMouthMap);

    return
end
