
clear 
     
IMG_Initial = imread("DB1/db1_05.jpg");
 
[IMG,leftEye,rightEye] = Face_Detection(IMG_Initial);
 
img = Face_Alignment_Normalization(IMG,leftEye,rightEye); 
    
test = TestEigen(img);

disp(test)