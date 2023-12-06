function [binaryGrayResultImage]=SkinColorDedection(Im)

    imageHeight = size(Im, 1);
    imageWidth = size(Im, 2);
    binaryImage = zeros(imageHeight, imageWidth);

    ycbcrImage = rgb2ycbcr(Im);
    cbChannel = ycbcrImage(:,:,2);
    crChannel = ycbcrImage(:,:,3);

    [rowIndices, colIndices] = find(cbChannel >= 77 & cbChannel <= 200 & crChannel >= 134 & crChannel <= 173);
    numIndices = size(rowIndices, 1);

    for i = 1:numIndices
        binaryImage(rowIndices(i), colIndices(i)) = 1;
    end

    structuringElement = strel('disk', 8, 4);

    openedImage = imopen(binaryImage, structuringElement);
    mask = imclose(openedImage, structuringElement);

    rgbFaceMaskedImage = Im .* uint8(mask);
    resultImage = rgbFaceMaskedImage;
    resultImage = im2double(resultImage);

    grayResultImage = rgb2gray(resultImage);
    binaryGrayResultImage = imbinarize(grayResultImage);

   
return; 