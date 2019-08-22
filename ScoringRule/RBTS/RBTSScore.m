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


