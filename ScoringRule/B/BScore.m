function u = BScore(x,y)
%newly proposed scoring rule
%   
    n = length(x);
    assert(length(x) == length(y),'x and y must be of the same length');
    
    %find means in true and false groups
    tPred = y(x==1);
    tPredMean = mean(tPred);
    fPred = y(x==0);
    fPredMean = mean(fPred);
    
    numT = nnz(x==1);
    numF = nnz(x==0);
    assert(numT+numF == n,'x contains non-binary entries');
    
    for i = 1:n
        if x(i) == 1
            tRatio = (numT-1)/(n-1);
            refPred = (tPredMean * numT - y(i))/(numT - 1); 
        else
            tRatio = numT/(n-1);
            refPred = (fPredMean * numF - y(i))/(numF - 1); 
        end
        u(i) = scoringRule(y(i), tRatio) ... % prediction score: how well the prediction meets actual report ratio
                + scoringRule(y(i), refPred); % information score: how well the prediction agree with peers
    end
end


