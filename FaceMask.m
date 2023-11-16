function [faceMask] = FaceMask(Im)

imgYCrBr1 = rgb2ycbcr(Im); 

Cb = im2double(imgYCrBr1(:,:,2));
Cr = im2double(imgYCrBr1(:,:,3));

 %Create the binary mask
    zeroMask = zeros(size(Cr));
    faceCol = zeroMask(1,:);
    faceRows = zeroMask(:,1);
    faceMask = zeros(size(zeroMask));

    %Set value to 1 if ceritain interval of Cb and Cr
    for i = 1:length(faceRows)
        for j = 1:length(faceCol)
            if Cr(i,j) < 0.6 && Cr(i,j) > 0.51 && Cb(i,j) < 0.56 && Cb(i,j) > 0.4
                faceMask(i,j) = 1;
            else
                faceMask(i,j) = 0;
            end
        end
    end

    %Morphological operations to remove blobs
    SE = strel('disk',8);
    faceMask = imdilate(faceMask, SE);
    faceMask = imdilate(faceMask, SE);
    %faceMask = imdilate(faceMask, SE);
    faceMask = imerode(faceMask, SE);

end
