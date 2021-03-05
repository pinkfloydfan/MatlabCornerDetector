% function for processing an image derivative that has negative or >255
% pixel values, scales according to min and max intensity and outputs a
% matrix of uint8.
function outputImage = normalizeImage(image)
    I_max = max(max(image));
    I_min = min(min(image));
    
    delta = I_max - I_min;
    
    scale = 255/delta; 
    outputImage = image*scale;
    
    if I_min < 0
        const = ones(size(image));
        const = const * (I_min*scale);
        
        outputImage = outputImage + const; 
    end
end