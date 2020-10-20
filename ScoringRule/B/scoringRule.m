% a variation of the brier scoring rule
function score = scoringRule(a,b)
    score = 1-(a-b).^2;
end

