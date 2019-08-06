function [result,majOutput,scoreOutput,tAverage,fAverage] = systemOutput(x,score)
    majOutput = -1;
    scoreOutput = -1;
    tVote = sum(x==1);
    fVote = sum(x==0);
    % majority
    if tVote > fVote
        majOutput = 1;
    elseif tVote < fVote
        majOutput = 0;
    end
    
    % score
    tAverage = mean(score(x==1));
    fAverage = mean(score(x==0));
    if tAverage > fAverage
        scoreOutput = 1;
    elseif tAverage < fAverage
        scoreOutput = 0;
    end
    
    if majOutput ~= -1 && scoreOutput ~= -1
        majScore = score(x==majOutput);
        meanMajScore = mean(majScore);
        maxMinScore = max(score(x==(1-majOutput)));
        numMajScoreOverMean = sum(majScore>meanMajScore);
        minMajScoreOverMean = unique(majScore(majScore>meanMajScore));
    
        if majOutput == scoreOutput
            result = majOutput;
        elseif numMajScoreOverMean >= 1/2*length(majScore) ...
            && minMajScoreOverMean > maxMinScore
            result = majOutput;
        else
            result = scoreOutput;
        end
    elseif majOutput ~= -1
        result = majOutput;
    elseif scoreOutput ~= -1
        result = scoreOutput;
    end
end

