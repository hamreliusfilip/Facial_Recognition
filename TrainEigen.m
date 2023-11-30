function [] = TrainEigen()

    load('Dataset.mat', 'allImages')

    % Parameters
    commonSize = [400, 400];
    numImages = numel(allImages); % Number of images in the dataset
    
    % Initialize matrix to store centered image vectors
    imageData = zeros(numImages, prod(commonSize));

    for i = 1:numImages
        img = allImages{i}; 

        % Convert the resized image to grayscale
        grayScale = im2gray(img);

        % Resize the image to the common size
        resizedImg = imresize(grayScale, commonSize);

        % Vectorize the grayscale image
        imgVector = double(resizedImg(:));

        % Store the vectorized image in the matrix
        imageData(i, :) = imgVector';

    end

    % Compute the mean face vector
    meanFaceVector = mean(imageData);

    % Subtract the mean face vector from each vector
    centeredImageData = imageData - meanFaceVector;

    % Built-in pca function
    [eigenVectors] = pca(centeredImageData);

    featureVector = eigenVectors(:, 1:15);

    % Save the meanFaceVector to a .mat file
    save('meanFaceVector.mat', 'meanFaceVector');

    % Save eigenfaces in a matrix
    eigenfacesMatrix = reshape(featureVector, [prod(commonSize), 15]);

    % Save the eigenfaces matrix to a .mat file
    save('eigenfacesMatrix.mat', 'eigenfacesMatrix');

    % Initialize matrices to store weights and scores for each image
    allWeights = zeros(15, numImages);
    allScores = zeros(15, numImages);

    for i = 1:numImages
        img = allImages{i}; 

        % Convert the resized image to grayscale
        grayScale = im2gray(img);

        % Resize the image to the common size
        resizedImg = imresize(grayScale, commonSize);

        % Vectorize the grayscale image
        imgVector = double(resizedImg(:));

        % Compute difference vector for current image
        diff = imgVector' - meanFaceVector;
        diff = reshape(diff, [], 1);

        % Calculate weights and scores for each eigenface
        for j = 1:15
            eigenfaceVector = eigenfacesMatrix(:, j);
            
            % Calculate the weight for each eigenface
            allWeights(j, i) = abs(eigenfaceVector' * diff);
            
            % Calculate the score for each eigenface
            allScores(j, i) = eigenfaceVector' * diff;
        end
    end

    % Save allWeights and allScores to .mat files
    save('allWeights.mat', 'allWeights');
    save('allScores.mat', 'allScores');

end
