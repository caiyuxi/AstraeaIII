function u = RBTSScore_mean(x,y)
%RBTSSCORE instead of reference and peer agent, use means as the information
%and prediction references. This still requires a minimum of 3 agents. 
%   
    prodY = prod(y);
    sumX = sum(x);
    n = length(x);
    assert(length(x) == length(y),'x and y must be of the same length');
    
    for i = 1:n
        % calculate the mean (excluding the current agent) for information 
        % and prediction reports respectively
        yRef  = (prodY / y(i)) ^ (1/(n - 1));
        xFreq = (sumX - x(i)) / (n - 1);
        % choose the popular side as x reference
        if xFreq < 0.5
            xRef = 0;
        elseif xFreq > 0.5
            xRef = 1;
        else
            % if 50:50, choose reference agent based on the original proposal
            if i + 2 == n
                xRef = x(i + 2);
            else
                xRef = x(mod(i+2,n));
            end
        end
        
        yPrim = findYPrim(x(i), yRef);
        u(i) = quadraticScoringRule(xRef, yPrim)... % information score
            + quadraticScoringRule(xRef, y(i));     % prediction score
        
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