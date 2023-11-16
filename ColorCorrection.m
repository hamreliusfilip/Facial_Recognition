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

if (0.8 < Div) && (Div < 1.3)
 
    correctedImg = Im;
    
elseif (correctionFactor(0) == correctionFactor(1)) && (correctionFactor(1) == correctionFactor(2))
    
    correctedImg = Im;
    
else 
    
    % Grey World 
    
    

    % Apply correction to each channel
    correctedImg = cat(3, R .* correctionFactor(1), G .* correctionFactor(2), B .* correctionFactor(3));
    
end


return

end