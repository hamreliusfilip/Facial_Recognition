function [output_image]=SkinColorDedection(Im)

    height = size(Im, 1);
    width = size(Im, 2);
    binaryIm = zeros(height, width);

    YCbCr = rgb2ycbcr(Im);
    Cb = YCbCr(:,:,2);
    Cr = YCbCr(:,:,3);

    [rowIndices, colIndices] = find(Cb >= 77 & Cb <= 200 & Cr >= 134 & Cr <= 173);
    numIndices = size(rowIndices, 1);

    for i = 1:numIndices
        binaryIm(rowIndices(i), colIndices(i)) = 1;
    end

    se = strel('disk', 8, 4);

    openedImage = imopen(binaryIm, se);
    mask = imclose(openedImage, se);

    rgbFaceMaskedImage = Im .* uint8(mask);
    resIm = rgbFaceMaskedImage;
    resIm = im2double(resIm);

    grayResIm = rgb2gray(resIm);
    output_image = imbinarize(grayResIm);

   
return; 