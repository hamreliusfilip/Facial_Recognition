clear 
clf 

allImages = cell(16, 1);

 for i = 1:16 
 
     if(i < 10)
         nr = "0" + i; 
     else
         nr = i;
     end
     
    IMG_Initial = imread("DB1/db1_"+ nr +".jpg");
 
    allImages{i} = IMG_Initial; 
    
 end 

 matFileName = 'DataSet.mat';
 save(matFileName, 'allImages');
 
 TrainEigen();