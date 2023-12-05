function [output_image] = MouthMap(Im)

    imgYCbCr = rgb2ycbcr(Im);

    Cr = double(imgYCbCr(:,:,3));
    Cb = double(imgYCbCr(:,:,2));


    numerator = 0.95 * sum(Cr.^2);
    denominator = sum(Cr./Cb);
    n = numerator / denominator;
    MouthMapC = Cr.^2 .* (Cr.^2 - (n .* (Cr./Cb))).^2;
    MouthMapC = im2double(MouthMapC);


    se = strel('disk', 4);
    MouthMapC = imclose(MouthMapC, se);
    MouthMapC = imopen(MouthMapC, se);


    MouthMapC = MouthMapC - min(MouthMapC(:));
    MouthMapC = MouthMapC / max(MouthMapC(:));

    threshold = 0.5;
    binaryMouthMap = MouthMapC > threshold;

    output_image = im2double(binaryMouthMap);

    return
end
