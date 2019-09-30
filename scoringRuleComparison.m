% single adversary, n = 10
clearvars;
x = [1 1 1 1 1 1 1 1 1 0];
y = [0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95];

BTSScore_dummy = BTSScore_dummy(x,y);
RBTSScore = RBTSScore(x,y);
BTSScore = BTSScore(x,y);
RBTSScore_mean = RBTSScore_mean(x,y);
RBTSScore_twoMeans = RBTSScore_twoMeans(x,y);

[BTSDummyResult,~,BTSDummyScoreOutput,BTSDummytAverage,BTSDummyfAverage] ...
                            = determinationModel1(x,BTSScore_dummy);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = determinationModel1(x,RBTSScore);
[RBTSMeanResult,~,RBTSMeanScoreOutput,RBTSMeantAverage,RBTSMeanfAverage] ...
                            = determinationModel1(x,RBTSScore_mean);
[RBTS2MeanResult,majOutput,RBTS2MeanScoreOutput,RBTS2MeantAverage,RBTS2MeanfAverage] ...
                            = determinationModel1(x,RBTSScore_twoMeans);        
%% 1 adversary, n = 100
clearvars;
x=zeros(1,100);
x(1,1:100) = 1;
x(100) = 0;
y=zeros(1,100);
y(:) = 0.95;

BTSScore_dummy = BTSScore_dummy(x,y);
RBTSScore = RBTSScore(x,y);
BTSScore = BTSScore(x,y);
RBTSScore_mean = RBTSScore_mean(x,y);
RBTSScore_twoMeans = RBTSScore_twoMeans(x,y);
    
[BTSResult,~,BTSScoreOutput,BTStAverage,BTSfAverage] ...
                            = determinationModel1(x,BTSScore);
[BTSDummyResult,~,BTSDummyScoreOutput,BTSDummytAverage,BTSDummyfAverage] ...
                            = determinationModel1(x,BTSScore_dummy);
[RBTSResult,~,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = determinationModel1(x,RBTSScore);
[RBTSMeanResult,~,RBTSMeanScoreOutput,RBTSMeantAverage,RBTSMeanfAverage] ...
                            = determinationModel1(x,RBTSScore_mean);
[RBTS2MeanResult,majOutput,RBTS2MeanScoreOutput,RBTS2MeantAverage,RBTS2MeanfAverage] ...
                            = determinationModel1(x,RBTSScore_twoMeans);
%% plotting
figure('Name','1 adversary, n=100');
hold on;
subplot(3,2,1);
plotWithDiffColor(x,y,1);
axis([-0.5 1.5 0 1]);
title('Prediction Report (y)');  




subplot(3,2,3);
plotWithDiffColor(x,BTSScore_dummy,1);
if ~isnan(BTSDummyfAverage)
    yline(BTSDummyfAverage,'b');
end
if ~isnan(BTSDummytAverage)
    yline(BTSDummytAverage,'r');
end
axis([-0.5 1.5 min(BTSScore_dummy)-0.5 max(BTSScore_dummy)+0.5]);
title('BTS score with dummy agents'); 

subplot(3,2,4);
plotWithDiffColor(x,RBTSScore,1);
if ~isnan(RBTSfAverage)
    yline(RBTSfAverage,'b');
end
if ~isnan(RBTStAverage)
    yline(RBTStAverage,'r');
end
axis([-0.5 1.5 min(RBTSScore)-0.2 max(RBTSScore)+0.2]);
title('RBTS score'); 


subplot(3,2,5);
plotWithDiffColor(x,RBTSScore_mean,1);
if ~isnan(RBTSMeanfAverage)
    yline(RBTSMeanfAverage,'b');
end
if ~isnan(RBTSMeantAverage)
    yline(RBTSMeantAverage,'r');
end
axis([-0.5 1.5 min(RBTSScore_mean)-0.2 max(RBTSScore_mean)+0.2]);
title('mean RBTS score'); 


subplot(3,2,6);
plotWithDiffColor(x,RBTSScore_twoMeans,1);
if ~isnan(RBTS2MeanfAverage)
    yline(RBTS2MeanfAverage,'b');
end
if ~isnan(RBTS2MeantAverage)
    yline(RBTS2MeantAverage,'r');
end
axis([-0.5 1.5 min(RBTSScore_twoMeans)-0.2 max(RBTSScore_twoMeans)+0.2]);
title('2 mean RBTS score'); 

%%
clearvars;
x = [1 1 1 1 1 1 1 1 1 1];
y = [0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.5];

BTSScore_dummy = BTSScore_dummy(x,y);
RBTSScore = RBTSScore(x,y);
BTSScore = BTSScore(x,y);
RBTSScore_mean = RBTSScore_mean(x,y);

[BTSDummyResult,~,BTSDummyScoreOutput,BTSDummytAverage,BTSDummyfAverage] ...
                            = determinationModel1(x,BTSScore_dummy);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = determinationModel1(x,RBTSScore);
                        
%% plotting
figure('Name','singleSignalTwoStates, n=3');
hold on;
subplot(3,1,1);
plotWithDiffColor(x,y,1);
axis([-0.5 1.5 0 1]);
title('Prediction Report (y)');  


subplot(3,1,2);
plotWithDiffColor(x,BTSScore_dummy,1);
if ~isnan(BTSDummyfAverage)
    yline(BTSDummyfAverage,'b');
end
if ~isnan(BTSDummytAverage)
    yline(BTSDummytAverage,'r');
end
axis([-0.5 1.5 min(BTSScore_dummy)-0.5 max(BTSScore_dummy)+0.5]);
title('BTS score with dummy agents'); 

subplot(3,1,3);
plotWithDiffColor(x,RBTSScore,1);
if ~isnan(RBTSfAverage)
    yline(RBTSfAverage,'b');
end
if ~isnan(RBTStAverage)
    yline(RBTStAverage,'r');
end
axis([-0.5 1.5 min(RBTSScore)-0.5 max(RBTSScore)+0.5]);
title('RBTS score'); 

