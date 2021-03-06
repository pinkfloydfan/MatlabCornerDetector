%function for creating a nxn window around a pixel, and performs the Harris
%operator on it.
%needs to be given the derivative matrices, the pixel this operates about,
%and the size of the window.
function H = window(Ix2, Iy2, Ixy, i, j, windowSize, type)

    offset = floor(windowSize/2);
    
    M = zeros(2);
    
    for n = j-offset:1:j+offset
        for m = i-offset:1:i+offset
            M = M + [Ix2(m,n), Ixy(m,n);
                     Ixy(m,n), Iy2(m,n)];
        end
    end
    
    if type == "LucasKanade"
        
        H = det(M) - 0.2*trace(M)^2;
        
    else
        
        H = min(eigs(M));
    end

    
    
end