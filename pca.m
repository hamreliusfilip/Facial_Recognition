% Define the path to your image folder
imageFolderPath = '/Users/milashahnavaz/Desktop/TNM034/DB1';

% Get a list of image files in the folder
imageFiles = dir(fullfile(imageFolderPath, '*.jpg')); % Change '*.jpg' based on your image format

numImages = numel(imageFiles); % Get the number of images

% Set the target size
targetSize = [650, 650];

% Initialize matrix to store image data
imageData = zeros(numImages, prod(targetSize)); % Initialize matrix

% Process each image in the folder
for i = 1:numImages
    % Read the image
    img = imread(fullfile(imageFolderPath, imageFiles(i).name));
    
    % Convert to grayscale 
    grayImage = rgb2gray(img);

    % Calculate padding needed to maintain aspect ratio
    [rows, cols, ~] = size(grayImage);
    padRows = max(0, targetSize(1) - rows);
    padCols = max(0, targetSize(2) - cols);
    
    % Pad the image to match the target size
    paddedImage = padarray(grayImage, [padRows, padCols], 0, 'post');
    
    % Resize the padded image to the target size
    resizedImage = imresize(paddedImage, targetSize);
    
    % Flatten the resized image into a vector and store in imageData matrix
    imgVector = reshape(resizedImage, 1, []);
    imageData(i, :) = imgVector;
end

% Calculate the mean face
meanFace = mean(imageData, 1); % Calculate mean along the rows (each pixel position)

% Subtract the mean face from each image vector
normalizedData = imageData - meanFace; % Subtract mean face from each image vector

% Transponera data för PCA-funktionen
dataTranspose = normalizedData';

% Beräkna kovariansmatrisen
covarianceMatrix = cov(dataTranspose);

% Utför egenvärdesanalys på kovariansmatrisen
[eigenVectors, eigenValues] = eig(covarianceMatrix);

% Sortera egenvärdena i fallande ordning
[eigenValuesSorted, sortIdx] = sort(diag(eigenValues), 'descend');
eigenVectorsSorted = eigenVectors(:, sortIdx);

% Välj antalet främsta egenvärden (till exempel, för att använda de 50 främsta egenvärdena)
numEigenFaces = 50;
principalComponents = eigenVectorsSorted(:, 1:numEigenFaces);

% Beräkna Eigenfaces genom att multiplicera principalComponents med normaliserad data
eigenFaces = principalComponents' * normalizedData';

% Beräkna den totala summan av egenvärden
totalEigenValuesSum = sum(eigenValuesSorted);

% Beräkna förklarad varians för varje egenvärde
explainedVariance = cumsum(eigenValuesSorted) / totalEigenValuesSum;

% Hitta det minsta antalet egenvärden som förklarar en viss procent av variansen
desiredVarianceExplained = 0.95; % till exempel, 95% av variansen
numImportantEigenValues = find(explainedVariance >= desiredVarianceExplained, 1);

% Välj de viktigaste egenvärdena och deras motsvarande egenvärdesvektorer
importantEigenVectors = eigenVectorsSorted(:, 1:numImportantEigenValues);

% Använd de viktigaste egenvärdena för att transformera dina data
importantFeatures = importantEigenVectors' * normalizedData';



