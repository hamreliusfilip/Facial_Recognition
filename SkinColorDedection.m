function [grayImage]=SkinColorDedection(Im)

  height = size(Im,1);
    width = size(Im,2);

    binaryImg = zeros(height,width);

    img_ycbcr = rgb2ycbcr(Im);
    Cb = img_ycbcr(:,:,2);
    Cr = img_ycbcr(:,:,3);

    HSV = rgb2hsv(Im);
    H = HSV(:,:,1);
    S = HSV(:,:,2);
    
    [r,c] = find(Cb>=77 & Cb<=200 & Cr>=134 & Cr<=173);
    numind = size(r,1);

    for i=1:numind
        binaryImg(r(i),c(i)) = 1;
    end

    SE1 = strel('disk', 8, 4);

    openImg = imopen(binaryImg, SE1);
    mask = imclose(openImg, SE1);
    
    rgbFaceMask = Im.*uint8(mask);
    image = rgbFaceMask;
    image = im2double(image); 
    
    grayImage = rgb2gray(image);
    grayImage = imbinarize(grayImage);

return; 