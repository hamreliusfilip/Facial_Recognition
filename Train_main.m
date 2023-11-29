% 
% allImages = cell(16, 1);
% eigenfaces = cell(16,1);
% featureVectors = cell(16,1);
% 
% for i = 1:16 
% 
%     if(i < 10)
%         nr = "0" + i; 
%     else
%         nr = i;
%     end
% 
%     IMG_Initial = imread("DB1/db1_"+ nr +".jpg");
% 
%     [IMG,leftEye,rightEye] = Face_Detection(IMG_Initial);
% 
%     img = Face_Alignment_Normalization(IMG,leftEye,rightEye);
% 
%     subplot(2,5,i)
%     imshow(img)
% 
%    % [eigenfaces{i}, featureVectors{i}] = GetEigenFace(img);
% 
% end 
% 
% matFileName = 'DataSet.mat';
% save(matFileName, 'allImages');
% 
% matFileName2 = 'EigenFaces.mat'; 
% save(matFileName2, 'eigenfaces'); 
% 
% matFileName3 = 'FeatureVectors.mat'; 
% save(matFileName2, 'featureVectors'); 
% 
% load('DataSet.mat', 'allImages')
% %load('DataSet2.mat', 'eigenfaces')
% %load('DataSet3.mat', 'featureVectors')
% 
% for i = 1:16 
% 
%     img = allImages{i}; 
%     imshow(img);
% 
%     %img2 = eigenfaces{i}; 
%     %imshow(img2);
% 
%     %img3 = featureVectors{i}; 
%     %imshow(img3);
% 
% end
% 
% 


img = imread('DB1/db1_01.jpg');
test = TestEigen(img);
