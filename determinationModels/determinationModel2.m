%% This function follows the rule that
 %  - majority side makes up more than 2/3 of the total vote
 %      -> output the majority side
 %      -> else output the RBTS score side
function [result,majOutput,scoreOutput,tAverage,fAverage] = determinationModel2(x,score)
    majOutput = -1;
    scoreOutput = -1;
    n = length(x);
    tVote = sum(x==1);
    fVote = sum(x==0);
    majVote = -1;
    % majority
    if tVote > fVote
        majOutput = 1;
        majVote = tVote;
    elseif tVote < fVote
        majOutput = 0;
        majVote = fVote;
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
        if majVote > 2/3 * n
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

