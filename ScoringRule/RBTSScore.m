function u = RBTSScore(x,y)
%RBTSSCORE based on the original proposal
%   
    for i = 1:length(x)
        if i + 1 == length(x)
            j = i + 1;
        else
            j = mod(i+1,length(x));
        end
        if i + 2 == length(x)
            k = i + 2;
        else
            k = mod(i+2,length(x));
        end
        
        yPrim = findYPrim(x(i), y(j));
        u(i) = quadraticScoringRule(x(k), yPrim) + quadraticScoringRule(x(k), y(i));
        
    end
end

function yiPrim = findYPrim(xi,yj)
    if yj > 0.5
        delta = 1-yj;
    else
        delta = yj;
    end
    
    if xi == 1
        yiPrim = yj + delta;
    else
        yiPrim = yj - delta;
    end
end

function score = quadraticScoringRule(xi,yi)
    if xi == 1
        score = 2 * yi - yi^2;
    else
        score = 1 - yi^2;
    end
end