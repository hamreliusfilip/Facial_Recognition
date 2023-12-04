function outImg = ColorCorrection(img)

    % img: input image
    
    % Convert image to double for accurate calculations
    img = im2double(img);

    % Calculate the maximum value of the entire image
    maxVal = max(img(:));

    % Normalize the image to the maximum value
    outImg = img / maxVal;
    
    % Display the original and corrected images (optional)
    figure;
    subplot(1, 2, 1); imshow(img); title('Original Image');
    subplot(1, 2, 2); imshow(outImg); title('White Patch Corrected Image');
    
end
