function [] = TrainEigen()

load('Dataset.mat', 'allImages')

% Parameters
commonSize = [400, 400];

% Initialize the matrix to store the centered image vectors
imageData = zeros(16, prod(commonSize));

for i = 1:16
    
    img = allImages{i}; 
    
    % Convert the resized image to grayscale
    grayScale = im2gray(img);

    % Resize the image to the common size
    resizedImg = imresize(grayScale, commonSize);
   
    % Vectorize the grayscale image and store in the matrix
    imgVector = double(resizedImg(:));
   
    imageData(i, :) = reshape(imgVector, 1, []);
  
end

% Compute the mean face vector
meanFaceVector = mean(imageData);

% Save the meanFaceVector to a .mat file
save('meanFaceVector.mat', 'meanFaceVector');

% Subtract the mean face vector from each vector
centeredImageData = imageData - meanFaceVector;

% Built-in pca function
[eigenVectors] = pca(centeredImageData);

featureVector = eigenVectors(:, 1:15);

% Assuming commonSize = [400, 400]
eigenfaceSize = [400, 400];

% Create a structure to organize eigenfaces
eigenfacesStruct = struct();

% Reshape and display the first 10 eigenfaces
for i = 1:15
    eigenface = reshape(featureVector(:, i), eigenfaceSize);
    eigenfacesStruct.(['eigenface', num2str(i)]) = eigenface;
end

% Save the structure to a .mat file
save('eigenfacesStruct.mat', 'eigenfacesStruct');

end