function [id] = TestEigen(img)

    load('meanFaceVector.mat', 'meanFaceVector');
    load('eigenfacesMatrix.mat', 'eigenfacesMatrix');
    
    commonSize = [400, 400];

    grayScale = rgb2gray(img);

    resizedImg = imresize(grayScale, commonSize);

    imgVector = double(resizedImg(:));

    diff = imgVector' - meanFaceVector;
    
    diff = reshape(diff, [], 1);

    weights = zeros(1, 15);

  for i = 1:15
        % Extract each eigenface vector from the matrix
        eigenfaceVector = eigenfacesMatrix(:, i);
        
        weights(i) = abs(eigenfaceVector' * diff);
    end

    [~, minIndex] = min(weights);
    id = minIndex;
    
    % Lägg till treshold

end
