function [] = TrainEigen()

    load('Dataset.mat', 'allImages')

    % Parameters
    commonSize = [300, 300];
    numImages = numel(allImages); % Number of images in the dataset
    
    % Initialize matrix to store centered image vectors
    imageData = zeros(prod(commonSize), numImages);
    
    for i = 1:numImages
        img = allImages{i}; 

        [IMG, leftEye, rightEye] = Face_Detection(img);
        img = Face_Alignment_Normalization(IMG, leftEye, rightEye);

        % Convert the resized image to grayscale
        grayScale = im2gray(img);

        % Resize the image to the common size
        resizedImg = imresize(grayScale, commonSize);

        % Normalize to [0, 1]
        normalizedImg = double(resizedImg) / 255;

        % Vectorize the grayscale image
        imageData(:, i) = normalizedImg(:);
    end

    % Compute the mean face vector
    meanFace = mean(imageData, 2);

    % Reshape meanFace to its original size
    meanFaceImage = reshape(meanFace, commonSize);

    % Specify the file name for the PNG image
    outputFileName = 'meanFaceImage.png';

    % Save the meanFaceImage as a PNG file
    imwrite(meanFaceImage, outputFileName);

    % Subtract the mean face vector from each vector
    A = imageData - meanFace;

    % Create eigen vectors 
    C = A' * A;
    [v, ~] = eig(C);
    u = A * v;
    
    % Normalization of the eigen vectors
    for i = 1:16
        u(:, i) = u(:, i) / norm(u(:, i));
    end

    % Weights
    allWeights = u' * A;

    % Save the meanFaceVector to a .mat file
    save('meanFaceVector.mat', 'meanFace');

    % Save eigenfaces in a matrix
    eigenfacesMatrix = u;

    % Save the eigenfaces matrix to a .mat file
    save('eigenfacesMatrix.mat', 'eigenfacesMatrix');

    % Save allWeights to a .mat file
    save('allWeights.mat', 'allWeights');
    
end
