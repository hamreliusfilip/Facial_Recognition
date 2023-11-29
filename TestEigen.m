function [id] = TestEigen(img)

    load('meanFaceVector.mat', 'meanFaceVector');
    load('eigenfacesStruct.mat', 'eigenfacesStruct');
    
    commonSize = [400, 400];

    grayScale = rgb2gray(img);

    resizedImg = imresize(grayScale, commonSize);

    imgVector = double(resizedImg(:));

    diff = imgVector' - meanFaceVector;
    
    diff = reshape(diff, [], 1);

    weights = zeros(1, 15);

    for i = 1:15
        eigenfaceMatrix = eigenfacesStruct.(['eigenface', num2str(i)]);
        eigenfaceMatrix = eigenfaceMatrix(:);
        weights(i) = abs(eigenfaceMatrix' * diff);
    end

    id = 0;
    [~, minIndex] = min(weights);
    id = minIndex;

end
