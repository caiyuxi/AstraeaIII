function u = RBTSScore(x,y)
%RBTSSCORE based on the original RBTS proposal
%   
    n = length(x);
    assert(length(x) == length(y),'x and y must be of the same length');
    
    for i = 1:n
        % find out j:  
        % considering array index is 1-based in matlab,
        % excluding corner case when j = n = i + 1
        if i + 1 == n
            j = i + 1;
        else
            j = mod(i+1,n);
        end
        % find out k:  
        % considering array index is 1-based in matlab,
        % excluding corner case when k = n = i + 2
        if i + 2 == n
            k = i + 2;
        else
            k = mod(i+2,n);
        end
        
        yPrim = findYPrim(x(i), y(j));
        u(i) = quadraticScoringRule(x(k), yPrim) ... % information score
            + quadraticScoringRule(x(k), y(i));      % prediction score
        
    end
end

% helper function to findout yi' from the original proposal
function yiPrim = findYPrim(xi,yj)
    delta = min(1-yj, yj);
    
    if xi == 1
        yiPrim = yj + delta; % adjust up if information report is high
    else
        yiPrim = yj - delta; % adjust down if information report is low
    end
end

% classic quadratic scoring rule
function score = quadraticScoringRule(xi,yi)
    if xi == 1
        score = 2 * yi - yi^2;
    else
        score = 1 - yi^2;
    end
end