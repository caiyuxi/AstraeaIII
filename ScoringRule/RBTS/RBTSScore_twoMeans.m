function u = RBTSScore_twoMeans(x,y)
%RBTSSCORE instead of reference and peer agent, use mean values (excluding the current agent)
           % this produce the same resulted score as the RBSTScore_mean
%   
    % calculate the mean of T agents and F agents separately
    tPred = y(x==1);
    fPred = y(x==0);
    prodYT = prod(tPred);
    prodYF = prod(fPred);
    sumX = sum(x);
    n = length(x);
    assert(length(x) == length(y),'x and y must be of the same length');
    
    for i = 1:n
        curSide = x(i);
        curPred = y(i);
        yT = 0;
        yF = 0;
        if curSide == 1
            yT = (prodYT / curPred)) ^ (1/(length(tPred) - 1));
            yF = prodYF^ (1/length(fPred));
        else
            yT = prodYT^ (1/length(tPred));
            yF = (prodYF / curPred) ^ (1/(length(fPred) - 1));
        end
        
        % calculate the frequency of both answers excluding current agent
        % curSide = 1 if cur agent votes for t
        xtFreq = (length(tPred)-curSide) / (n - 1);
        xfFreq = (length(fPred)-(1-curSide)) / (n - 1);
        
        xRef = xtFreq>xfFreq;
        
        yPrim = xtFreq * findYPrim(x(i), yT) + xfFreq * findYPrim(x(i), yF);
        u(i) = quadraticScoringRule(xRef, yPrim) + quadraticScoringRule(xRef, y(i));
        
    end
end

