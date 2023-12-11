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
    C1 = A' * A;
    [V, ~] = eig(C1);
    u = A * V;
    
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
    

    %%%% Saving eigenfaces images %%%%

    % Specify the folder where you want to save the eigenfaces
    outputFolder = 'Eigenfaces';

    % Create the output folder if it doesn't exist
    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end

    % Rescale eigenfaces to the original intensity range [0, 255]
    scaledEigenfaces = (u - min(u(:))) * (255 / (max(u(:)) - min(u(:))));

    % Iterate over each eigenface
    for i = 1:size(scaledEigenfaces, 2)
        % Reshape the eigenface to its original size
        eigenface = reshape(scaledEigenfaces(:, i), commonSize);
    
        % Convert to uint8 (assuming original images were uint8)
        eigenface = uint8(eigenface);
    
        % Specify the file name for the PNG image
        outputFileName = fullfile(outputFolder, ['eigenface_', num2str(i), '.png']);
    
        % Save the eigenface as a PNG file
        imwrite(eigenface, outputFileName);
    end

end
