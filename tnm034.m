function [int] = tnm034(IMG)

[IMG,leftEye,rightEye] = Face_Detection(IMG);

img = Translation(IMG,leftEye,rightEye);

[eigenface, featureVector] = GetEigenFace(img);


load('DataSet2.mat', 'eigenfaces')
load('DataSet3.mat', 'featureVectors')

for i = 1:16 

    dis = abs(featureVector - featureVectors{i}; 
    
    if dis < 0.3
        int = i; 
    end 

end 