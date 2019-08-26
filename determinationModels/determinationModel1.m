%% This function follows the rule that
 %  - majority side = the side with higher average RBTS score 
 %      -> output the agreed side
 %  - majority side != the side with higher average RBTS score 
 %      - majority of majority have a score higher than the majority
 %      average score
 %      - minimum score of the majority of majority is higher than the
 %      maximum score of the opposite side
 %          -> output the majority side
 %          -> else output the RBTS score side
function [result,majOutput,scoreOutput,tAverage,fAverage] = determinationModel1(x,score)
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
        minMajScoreOverMean = min(unique(majScore(majScore>meanMajScore)));
    
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

