function [importantFeatures] = pca(IMG)

% Define the path to your image folder
imageFolderPath = 'DB1';

% Get a list of image files in the folder
imageFiles = dir(fullfile(imageFolderPath, '*.jpg')); 

% Get the number of images
numImages = numel(imageFiles);

targetsize = [650, 900]; % Uppdatera targetsize till den önskade storleken

% Initialize matrix to store image data without reshaping
imageData = zeros(numImages, prod(targetsize)); 

% Process each image in the folder
for i = 1:numImages
    % Read the image
    img = imread(fullfile(imageFolderPath, imageFiles(i).name));
    
    % Convert image to column vector and store
    imgVector = double(img(:)); 
    
    meanFace = mean(imgVector);

    % Subtract mean face from each image vector
    normalizedData = imgVector - meanFace; 
     
    % Store normalized vector in the matrix
    imageData(i, 1:numel(normalizedData)) = normalizedData';
end

% Transponera data för PCA-funktionen
dataTranspose = normalizedData';

% Beräkna kovariansmatrisen
covarianceMatrix = cov(dataTranspose);

% Utför egenvärdesanalys på kovariansmatrisen
[eigenVectors, eigenValues] = eig(covarianceMatrix);

% Sortera egenvärdena i fallande ordning
[eigenValuesSorted, sortIdx] = sort(diag(eigenValues), 'descend');
eigenVectorsSorted = eigenVectors(:, sortIdx);

% Kontrollera storleken på eigenVectorsSorted
sizeEigenVectorsSorted = size(eigenVectorsSorted);

% Välj antalet tillgängliga egenvärden
numAvailableEigenValues = sizeEigenVectorsSorted(2); % Antalet kolumner i eigenVectorsSorted

% Välj antalet främsta egenvärden baserat på tillgängliga egenvärden
numEigenFaces = min(10, numAvailableEigenValues); % Välj det minsta mellan 10 och antalet tillgängliga egenvärden

% Skapa principalComponents med rätt antal egenvärden
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

