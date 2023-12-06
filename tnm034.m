function id = tnm034(im) 

[IMG,leftEye,rightEye] = Face_Detection(im); 
img = Face_Alignment_Normalization(IMG,leftEye,rightEye); 

id = TestEigen(img);

end 