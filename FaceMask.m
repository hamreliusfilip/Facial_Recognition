function [faceBinaryMask] = FaceMask(Im)

ycbcrImage = rgb2ycbcr(Im);

cbChannel = im2double(ycbcrImage(:,:,2));
crChannel = im2double(ycbcrImage(:,:,3));

zeroMask = zeros(size(crChannel));
faceColumns = zeroMask(1, :);
faceRows = zeroMask(:, 1);
faceBinaryMask = zeros(size(zeroMask));

for i = 1:length(faceRows)
    for j = 1:length(faceColumns)
        if crChannel(i, j) < 0.7 && crChannel(i, j) > 0.6 && cbChannel(i, j) < 0.6 && cbChannel(i, j) > 0.5
            faceBinaryMask(i, j) = 1;
        else
            faceBinaryMask(i, j) = 0;
        end
    end
end

structuringElement = strel('disk', 5);

faceBinaryMask = imdilate(faceBinaryMask, structuringElement);

faceBinaryMask = imerode(faceBinaryMask, structuringElement);

end
