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