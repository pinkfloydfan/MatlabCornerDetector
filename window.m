function H = window(Ix2, Iy2, Ixy, i, j, windowSize)

    offset = floor(windowSize/2);
    
    M = zeros(2);
    
    for n = j-offset:1:j+offset
        for m = i-offset:1:i+offset
            M = M + [Ix2(m,n), Ixy(m,n);
                     Ixy(m,n), Iy2(m,n)];
        end
    end
    
    H = det(M) - 0.2*trace(M)^2;
    
end