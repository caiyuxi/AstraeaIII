%% case 1: single minority with high score where BTS doesn't return a robust result
clearvars;
x = [1 1 1 1 1 1 1 1 1 0];
y = [0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95];

RBTSScore = RBTSScore(x,y);
RBTSScore_mean = RBTSScore_mean(x,y);

[RBTSMeanResult,~,RBTSMeanScoreOutput,RBTSMeantAverage,RBTSMeanfAverage] ...
                            = determinationModel1(x,RBTSScore_mean);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = determinationModel1(x,RBTSScore);
%% case 2: single minority with n=100
clearvars;
x=zeros(1,100);
x(1,100) = 1;
y=zeros(1,100);
y(:) = 0.95;

RBTSScore = RBTSScore(x,y);
RBTSScore_mean = RBTSScore_mean(x,y);

[RBTSMeanResult,~,RBTSMeanScoreOutput,RBTSMeantAverage,RBTSMeanfAverage] ...
                            = determinationModel1(x,RBTSScore_mean);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = determinationModel1(x,RBTSScore);
                        
%% case 3: 10 minority with n=100
clearvars;
x1=zeros(1,100);
x1(1,91:100) = 1;
y=zeros(1,100);
y(:) = 0.9;

% shuffle the report array
idx = randperm(100);
x = x1;
x(1,idx) = x1(1,:);

RBTSScore = RBTSScore(x,y);
RBTSScore_mean = RBTSScore_mean(x,y);

[RBTSMeanResult,~,RBTSMeanScoreOutput,RBTSMeantAverage,RBTSMeanfAverage] ...
                            = determinationModel1(x,RBTSScore_mean);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = determinationModel1(x,RBTSScore);
        
%% case 4: n=100, 100 random cases, find number of agreement among majority, RBTS and improved RBTS
clearvars;
AllAgreeCount = 0;
RBTSAgreeCount = 0;
RBTSMeanMajorityCount = 0;
RBTSMajorityCount = 0;
for i = 1:100
    [x,y] =randomAgents(100);
    clear RBTSScore;
    clear RBTSScore_mean;
    clear majOutput;
    clear RBTSMeanScoreOutput;
    clear RBTSScoreOutput;
    
    RBTSScore = RBTSScore(x,y);
    RBTSScore_mean = RBTSScore_mean(x,y);

    [RBTSMeanResult,~,RBTSMeanScoreOutput,RBTSMeantAverage,RBTSMeanfAverage] ...
                                = determinationModel1(x,RBTSScore_mean);
    [RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                                = determinationModel1(x,RBTSScore);
    if (majOutput == RBTSScoreOutput && majOutput == RBTSMeanScoreOutput) 
        AllAgreeCount = AllAgreeCount+1;
    end
    if (majOutput == RBTSScoreOutput) 
        RBTSMajorityCount = RBTSMajorityCount+1;
    end
    if (majOutput == RBTSMeanScoreOutput) 
        RBTSMeanMajorityCount = RBTSMeanMajorityCount+1;
    end
    if (RBTSScoreOutput == RBTSMeanScoreOutput) 
        RBTSAgreeCount = RBTSAgreeCount+1;
    end
end
% result:
% run1: AllAgreeCount = 57, RBTSMajorityCount=57, RBTSMeanMajorityCount =
% 95, RBTSAgreeCount = 60
% run2: AllAgreeCount = 65, RBTSMajorityCount=65, RBTSMeanMajorityCount =
% 92, RBTSAgreeCount = 68
% run2: AllAgreeCount = 62, RBTSMajorityCount=62, RBTSMeanMajorityCount =
% 94, RBTSAgreeCount = 65

%% case 5: n=100, 100 random cases, but make sures that if xi = 1, yi>=0.5, 
 % find number of agreement among majority, RBTS and improved RBTS
clearvars;
AllAgreeCount = 0;
RBTSAgreeCount = 0;
RBTSMeanMajorityCount = 0;
RBTSMajorityCount = 0;
for i = 1:100
    [x,y] =randomAgents2(100);
    clear RBTSScore;
    clear RBTSScore_mean;
    clear majOutput;
    clear RBTSMeanScoreOutput;
    clear RBTSScoreOutput;
    
    RBTSScore = RBTSScore(x,y);
    RBTSScore_mean = RBTSScore_mean(x,y);

    [RBTSMeanResult,~,RBTSMeanScoreOutput,RBTSMeantAverage,RBTSMeanfAverage] ...
                                = determinationModel1(x,RBTSScore_mean);
    [RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                                = determinationModel1(x,RBTSScore);
    if (majOutput == RBTSScoreOutput && majOutput == RBTSMeanScoreOutput) 
        AllAgreeCount = AllAgreeCount+1;
    end
    if (majOutput == RBTSScoreOutput) 
        RBTSMajorityCount = RBTSMajorityCount+1;
    end
    if (majOutput == RBTSMeanScoreOutput) 
        RBTSMeanMajorityCount = RBTSMeanMajorityCount+1;
    end
    if (RBTSScoreOutput == RBTSMeanScoreOutput) 
        RBTSAgreeCount = RBTSAgreeCount+1;
    end
end
% result:
% run1: AllAgreeCount = 72, RBTSMajorityCount=72, RBTSMeanMajorityCount =
% 93, RBTSAgreeCount = 76
% run2: AllAgreeCount = 75, RBTSMajorityCount=75, RBTSMeanMajorityCount =
% 94, RBTSAgreeCount = 79
% run2: AllAgreeCount = 68, RBTSMajorityCount=68, RBTSMeanMajorityCount =
% 91, RBTSAgreeCount = 75
%%                        
% conclusion: although using mean instead of reference and peer agents 
% removes randomness from the protocol. The scores for agents reporting the 
% same report are the same. 