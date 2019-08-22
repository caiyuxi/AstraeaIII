% classic quadratic scoring rule
function score = quadraticScoringRule(xi,yi)
    if xi == 1
        score = 2 * yi - yi^2;
    else
        score = 1 - yi^2;
    end
end