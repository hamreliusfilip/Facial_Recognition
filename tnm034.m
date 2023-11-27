function [int] = tnm034(IMG)

[IMG,leftEye,rightEye] = Face_Detection(IMG);

img = Translation(IMG,leftEye,rightEye);

% Hämta features från PCA & Eigenfaces 




load('DataSet.mat', 'allImages')

for i = 1:16 

    % Jämför features med alla feutures i datasetet och Bestäm vilken som liknar mest 
    
    % Treshold for acceptable face 

end


% Retunera bildens index

end 