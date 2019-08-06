%% case 1: single minority with high score where BTS doesn't return a robust result
clearvars;
x = [1 1 1 1 1 1 1 1 1 0];
y = [0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95];

RBTSScore = RBTSScore(x,y);
RBTSScore_mean = RBTSScore_mean(x,y);

[RBTSMeanResult,~,RBTSMeanScoreOutput,RBTSMeantAverage,RBTSMeanfAverage] ...
                            = systemOutput(x,RBTSScore_mean);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = systemOutput(x,RBTSScore);
%% case 2: single minority with n=100
clearvars;
x=zeros(1,100);
x(1,100) = 1;
y=zeros(1,100);
y(:) = 0.95;

RBTSScore = RBTSScore(x,y);
RBTSScore_mean = RBTSScore_mean(x,y);

[RBTSMeanResult,~,RBTSMeanScoreOutput,RBTSMeantAverage,RBTSMeanfAverage] ...
                            = systemOutput(x,RBTSScore_mean);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = systemOutput(x,RBTSScore);
                        
%% case 3: 10 minority with n=100
clearvars;
x1=zeros(1,100);
x1(1,91:100) = 1;
y=zeros(1,100);
y(:) = 0.95;

% shuffle the report array
idx = randperm(100);
x = x1;
x(1,idx) = x1(1,:);

RBTSScore = RBTSScore(x,y);
RBTSScore_mean = RBTSScore_mean(x,y);

[RBTSMeanResult,~,RBTSMeanScoreOutput,RBTSMeantAverage,RBTSMeanfAverage] ...
                            = systemOutput(x,RBTSScore_mean);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = systemOutput(x,RBTSScore);
                        

%%                        
% conclusion: although using mean instead of reference and peer agents 
% removes randomness from the protocol. The scores for agents reporting the 
% same report are the same. It also does not affect the oracle output. 