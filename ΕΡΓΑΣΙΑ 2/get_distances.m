function [dh, dv] = get_distances(x, y)

if (x <= 5)
    dv = y;
    if (y <= 1)
        dh = 5 - x;
    elseif (y <= 2)
        dh = 6 - x;
    elseif (y <= 3)
        dh = 7 - x;
    else
        dh = 11 - x;
    end
elseif (x <= 6)
    dv = y - 1;
    if (y <= 2)
        dh  = 6 - x;
    elseif (y <= 3)
        dh = 7 - x;
    else
        dh = 11 - x;
    end
elseif (x <= 7)
    dv = y - 2;
    if (y <= 3)
        dh = 7 - x;
    else
        dh = 11 - x;
    end
elseif (x <= 10)
    dv = y - 3;
    dh = 11 - x;
end

% maximum value of distance is one
if (dv>1)
    dv = 1;
end
if (dh>1)
    dh=1;
end

end

