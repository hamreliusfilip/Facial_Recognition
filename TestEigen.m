function [featureVector] = TestEigen(img)

    load('meanFaceVector.mat', 'meanFaceVector');
    load('eigenfacesMatrix.mat', 'eigenfacesMatrix');
    
    commonSize = [400, 400];

    grayScale = rgb2gray(img);

    resizedImg = imresize(grayScale, commonSize);

    imgVector = double(resizedImg(:));

    diff = imgVector' - meanFaceVector;
    
    diff = reshape(diff, [], 1);

    % Initialize featureVector
    featureVector = zeros(15, 1);

    for i = 1:15
        % Extract each eigenface vector from the matrix
        eigenfaceVector = eigenfacesMatrix(:, i);
        
        % Calculate the weight for each eigenface
        weights = abs(eigenfaceVector' * diff);
        featureVector(i) = weights;
    end
    
end
