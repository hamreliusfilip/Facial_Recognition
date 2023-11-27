
function [] = GetEigenFace(img)

% Parameters
commonSize = [400, 400];
imageFolderPath = 'DB1';

% Load images and compute mean face
imageFiles = dir(fullfile(imageFolderPath, '*.jpg'));

% Get number of images
numImages = numel(imageFiles) + 1; % +1 pga classify bilden

% Initialize the matrix to store the centered image vectors
imageData = zeros(numImages, prod(commonSize));

% ensamma bilden
grayScaleInput = im2gray(img);
resizedImgInput = imresize(grayScaleInput, commonSize);
imgVectorInput = reshape(resizedImgInput, 1, []);
imageData(1, :) = imgVectorInput; % Ensamma bilden

for i = 2:numImages
    
    img = imread(fullfile(imageFolderPath, imageFiles(i - 1).name));
    
    % Convert the resized image to grayscale
    grayScale = rgb2gray(img);

    % Resize the image to the common size
    resizedImg = imresize(grayScale, commonSize);
   
    % Vectorize the grayscale image and store in the matrix
    %imgVector = double(grayScale(:));
    %imageData(:, i) = imgVector;

    imageData(i, :) = reshape(resizedImg, 1, []);
    
end


% Compute the mean face vector
meanFaceVector = mean(imageData);

% Subtract the mean face vector from each vector
centeredImageData = imageData - meanFaceVector;

% Built-in pca function
[eigenVectors,~,~] = pca(centeredImageData);

top_eigVec = eigenVectors(:, 1:15);

% eigenFaces = reshape(top_eigVec, 1, [])

% Assuming commonSize = [400, 400]
eigenfaceSize = [400, 400];

% Create a directory to save
eigenfacesFolderPath = 'Eigenfaces';
if ~exist(eigenfacesFolderPath, 'dir')
    mkdir(eigenfacesFolderPath);
end

FeatureVectorFolderPath = 'FeatureVector';
if ~exist(FeatureVectorFolderPath, 'dir')
    mkdir(FeatureVectorFolderPath);
end

% Reshape and display the first 10 eigenfaces

for i = 1:10
    eigenface = reshape(top_eigVec(:, i), eigenfaceSize);
    featurevec = top_eigVec(:, i); 
    
    imwrite(eigenface, fullfile(eigenfacesFolderPath, ['Eigenface_', num2str(i), '.png']));
    imwrite(featurevec, fullfile(FeatureVectorFolderPath, ['Featurevec_', num2str(i), '.png']));
end


end