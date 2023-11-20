function [correctedImg]=ColorCorrection(Im)

R = Im(:,:,1);
G = Im(:,:,2);
B = Im(:,:,3);

AR = mean(R(:)); 
AG = mean(G(:)); 
AB = mean(B(:)); 

Max = max([AR, AG, AB]);
Min = min([AR, AG, AB]);
 
Div = Max ./ Min; 
 
% Calculate average color
averageColor = (mean(R(:)) + mean(G(:)) + mean(B(:))) / 3;
 
% Calculate correction factor
correctionFactor = averageColor ./ [mean(R(:)), mean(G(:)), mean(B(:))];
 
 
if (0.3 < Div) && (Div < 1.8) 
 
    correctedImg = Im;
    
%elseif (AR > 180)
    
  %  test = 5
   % correctedImg = cat(3, R .* correctionFactor(1), G, B);
    
elseif ((abs(correctionFactor(1)) == abs(correctionFactor(2))) && (abs(correctionFactor(2)) == abs(correctionFactor(3))))
    
    correctedImg = Im;
    
else 
    
    % Grey World 
  
    correctedImg = cat(3, R .* correctionFactor(1), G .* correctionFactor(2), B .* correctionFactor(3));
    
end
 
 
return

end