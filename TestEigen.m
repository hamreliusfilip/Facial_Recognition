function [id] = TestEigen(img)

    load('meanFaceVector.mat', 'meanFaceVector');
    load('eigenfacesMatrix.mat', 'eigenfacesMatrix');
    load('allWeights.mat', 'allWeights'); % Load training weights
    load('allScores.mat', 'allScores'); % Load training scores
    
    commonSize = [400, 400];

    grayScale = rgb2gray(img);

    resizedImg = imresize(grayScale, commonSize);

    imgVector = double(resizedImg(:));

    diff = imgVector' - meanFaceVector;
    
    diff = reshape(diff, [], 1);

    % Calculate weights and scores for the test image
    testWeights = zeros(15, 1);
    testScores = zeros(15, 1);

    for i = 1:15
        % Extract each eigenface vector from the matrix
        eigenfaceVector = eigenfacesMatrix(:, i);
        
        % Calculate the weight for each eigenface
        testWeights(i) = abs(eigenfaceVector' * diff);
        
        % Calculate the score for each eigenface
        testScores(i) = eigenfaceVector' * diff;
    end

    % Compare test image's weights and scores with training dataset
    smallestDistance = inf;
    id = 0; 
    
    for i = 1:size(allWeights, 2)
        % Compute distance between test image weights/scores and each training sample
        distance = norm(allScores(:, i) - testScores) + norm(allWeights(:, i) - testWeights);
        
        if (distance < smallestDistance)
            smallestDistance = distance;
            id = i; % Store the index of the closest match
        end
    end
    
%     min_val = 0.3;
%     
%     if(smallestDistance > min_val)
%         id = 0;
%     end

end
