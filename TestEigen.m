function [result] = TestEigen(img)

    commonSize = [400, 400];

    % Convert the resized image to grayscale
    grayScale = rgb2gray(img);

    % Resize the image to the common size
    resizedImg = imresize(grayScale, commonSize);
   
    % Vectorize the grayscale image and store in the matrix
    imgVector = double(resizedImg(:));
   

% Load mean
load('meanFaceVector.mat', 'meanFaceVector');

% Load training set
load('TrainingSet.mat','TrainingSet');

 % Compute weights (projection)
    weights = phi_i' * TrainingSet.eigenVectors;

    % Compare with training set
    distances = zeros(size(TrainingSet.weights, 1), 1);
    for i = 1:size(TrainingSet.weights, 1)
        distances(i) = norm(weights - TrainingSet.weights(i, :));
    end

    % Find the index of the closest match
    [~, minIndex] = min(distances);

    % Set a threshold (you may need to adjust this)
    threshold = 500;  % Experiment with different threshold values

    % Check if the closest match is below the threshold
    if distances(minIndex) < threshold
        result = minIndex;  % Return the index of the matched face
    else
        result = 0;  % Return 0 if the image is not in the training set
    end
end