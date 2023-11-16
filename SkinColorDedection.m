function [grayImage]=SkinColorDedection(Im)

  height = size(Im,1);
    width = size(Im,2);

    %Initialize a binary image
    binaryImg = zeros(height,width);

    %Change color space
    img_ycbcr = rgb2ycbcr(Im);
    Cb = img_ycbcr(:,:,2);
    Cr = img_ycbcr(:,:,3);
    %imshow(Cb)
    HSV = rgb2hsv(Im);
    H = HSV(:,:,1);
    S = HSV(:,:,2);
    
    % Find pixels with chroma values in skin range
    [r,c] = find(Cb>=77 & Cb<=200 & Cr>=134 & Cr<=173);
    numind = size(r,1);

    %Set value to pixels with skin color
    for i=1:numind
        binaryImg(r(i),c(i)) = 1;
    end

    % Open and close to create mask
    SE1 = strel('disk', 14, 4);

    openImg = imopen(binaryImg, SE1);
    mask = imclose(openImg, SE1);
    
    rgbFaceMask = Im.*uint8(mask);
    image = rgbFaceMask;
    image = im2double(image); 
    
    grayImage = rgb2gray(image);
    grayImage = imbinarize(grayImage);

return; 