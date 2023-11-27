
%allImages = cell(16, 1);


%for i = 1:16 
    
    %if(i < 10)
     %   nr = "0" + i; 
    %else
     %   nr = i;
    %end
    
    %IMG_Initial = imread("DB1/db1_"+ nr +".jpg");

    %[IMG,leftEye,rightEye] = Face_Detection(IMG_Initial);
    
   % img = Face_Alignment_Normalization(IMG,leftEye,rightEye);
  %  allImages{i} = img; 
    
 %   GetEigenFace(img); 
     

%end 

%save('DataSet.mat', 'allImages');

%load('DataSet.mat', 'allImages')



IMG_Test = imread("DB1/db1_07.jpg");
[IMG, leftEye, rightEye] = Face_Detection(IMG_Test);
img = Face_Alignment_Normalization(IMG, leftEye, rightEye);
GetEigenFace(img);

eigenfacesFolderPath = 'Eigenfaces';
FeatureVectorFolderPath = 'FeatureVector';

% Load the first feature vector for comparison
FeatureVecFileName = fullfile(FeatureVectorFolderPath, ['Featurevec_1.png']);
featurevec1 = imread(FeatureVecFileName);

minDistance = Inf;
minIndex = -1;

% Compare the first feature vector to the others
for i = 2:15
    FeatureVecFileName = fullfile(FeatureVectorFolderPath, ['Featurevec_', num2str(i), '.png']);
    featurevec2 = imread(FeatureVecFileName);
    
    % Calculate Euclidean distance between feature vectors
    distance = norm(double(featurevec1(:)) - double(featurevec2(:)));
    
    % Check if the current distance is smaller than the minimum
    if distance < minDistance
        minDistance = distance;
        minIndex = i;
    end
end

% Display the result
fprintf('The smallest distance is %f with index %d\n', minDistance, minIndex);

% Display the first feature vector
subplot(3, 5, 1);
imshow(featurevec1, []);
title('Reference Feature Vector');

% Display the feature vector with the smallest distance
subplot(3, 5, minIndex);
FeatureVecFileName = fullfile(FeatureVectorFolderPath, ['Featurevec_', num2str(minIndex), '.png']);
featurevecMin = imread(FeatureVecFileName);
imshow(featurevecMin, []);
title(['Closest Feature Vector (Index ', num2str(minIndex - 1), ')']);


