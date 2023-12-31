function [faceMask] = FaceMask(Im)

imgYCrBr1 = rgb2ycbcr(Im); 

Cb = im2double(imgYCrBr1(:,:,2));
Cr = im2double(imgYCrBr1(:,:,3));

    zeroMask = zeros(size(Cr));
    faceCol = zeroMask(1,:);
    faceRows = zeroMask(:,1);
    faceMask = zeros(size(zeroMask));

    for i = 1:length(faceRows)
        for j = 1:length(faceCol)
            if Cr(i,j) < 0.7 && Cr(i,j) > 0.6 && Cb(i,j) < 0.6 && Cb(i,j) > 0.5
                faceMask(i,j) = 1;
            else
                faceMask(i,j) = 0;
            end
        end
    end

    SE = strel('disk',5);
    
    faceMask = imdilate(faceMask, SE);

    faceMask = imerode(faceMask, SE);

end
