% helper function to findout yi' from the original proposal
function yiPrim = findYPrim(xi,yj)
    delta = min(1-yj, yj);
    
    if xi == 1
        yiPrim = yj + delta; % adjust up if information report is high
    else
        yiPrim = yj - delta; % adjust down if information report is low
    end
end