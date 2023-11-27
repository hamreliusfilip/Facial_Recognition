
function [eigenface, featureVector] = GetEigenFace(IMG)

% Parameters
%commonSize = [400, 400];
%mageFolderPath = 'DB1';

% Load images and compute mean face
%imageFiles = IMG;

% Get number of images
%numImages = numel(imageFiles);

% Initialize the matrix to store the centered image vectors
%imageData = zeros(numImages, prod(commonSize));

%for i = 1:numImages
 %   img = imread(fullfile(imageFolderPath, imageFiles(i).name));
    
    % Convert the resized image to grayscale
  %  grayScale = im2gray(img);

    % Resize the image to the common size
   % resizedImg = imresize(grayScale, commonSize);
   
    % Vectorize the grayscale image and store in the matrix
    %imgVector = double(grayScale(:));
    %imageData(:, i) = imgVector;

    %imageData(i, :) = reshape(resizedImg, 1, []);
%end

imshow(IMG)
IMG

% Compute the mean face vector
meanFaceVector = mean(IMG);

% Subtract the mean face vector from each vector
centeredImageData = imageData - meanFaceVector;

% Built-in pca function
[eigenVectors] = pca(centeredImageData);

featureVector = eigenVectors(:, 1:10);

% eigenFaces = reshape(top_eigVec, 1, [])

% Assuming commonSize = [400, 400]
eigenfaceSize = [400, 400];

% Reshape and display the first 10 eigenfaces
for i = 1:10
    eigenface = reshape(featureVector(:, i), eigenfaceSize);
    %subplot(2, 5, i);
    %imshow(eigenface, []);
    %title(['Eigenface ', num2str(i)]);
end

end
