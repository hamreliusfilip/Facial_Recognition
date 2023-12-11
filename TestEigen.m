function [id] = TestEigen(img)

    load('meanFaceVector.mat', 'meanFace');
    load('eigenfacesMatrix.mat', 'eigenfacesMatrix');
    load('allWeights.mat', 'allWeights');
    
    % Set common size for image processing
    commonSize = [300, 300];

    % Face detection and alignment
    [IMG, leftEye, rightEye] = Face_Detection(img);
    img = Face_Alignment_Normalization(IMG, leftEye, rightEye);
    img = im2double(img);
    
    grayScale = rgb2gray(img);
    resizedImg = imresize(grayScale, commonSize);

    % Subtract mean face vector
    diff = resizedImg(:) - meanFace;
        
    % Project the query image onto the eigenfaces to get weights
    queryWeights = eigenfacesMatrix' * diff;

    % Normalize the weights of the new image
    u = zeros(1, 16);

    % Normalization of the eigen vectors
    for i = 1:16
        u(i) = norm(allWeights(:, i) - queryWeights(:));
    end

    % Find the smallest error
    [value, index] = min(u);

    % Set a threshold to determine if it's a match 
    threshold = 19.8;

    if (value < threshold)
        id = index;
    else
        id = 0; % No match
    end
    
end
