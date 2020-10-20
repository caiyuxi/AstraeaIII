%% random, n=3
clearvars;
[x,y] = randomAgents(3);
BTSScore_dummy = BTSScore_dummy(x,y);
RBTSScore = RBTSScore(x,y);

[BTSDummyResult,~,BTSDummyScoreOutput,BTSDummytAverage,BTSDummyfAverage] ...
                            = determinationModel1(x,BTSScore_dummy);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = determinationModel1(x,RBTSScore);
                        
%% plotting
figure('Name','randomAgents, n=3');
hold on;
subplot(3,1,1);
scatter(x,y);
axis([-0.5 1.5 0 1]);
title('Prediction Report (y)');  


subplot(3,1,2);
scatter(x,BTSScore_dummy);
if ~isnan(BTSDummyfAverage)
    yline(BTSDummyfAverage,'b');
end
if ~isnan(BTSDummytAverage)
    yline(BTSDummytAverage,'r');
end
axis([-0.5 1.5 min(BTSScore_dummy)-0.5 max(BTSScore_dummy)+0.5]);
title('BTS score with dummy agents'); 

subplot(3,1,3);
scatter(x,RBTSScore);
if ~isnan(RBTSfAverage)
    yline(RBTSfAverage,'b');
end
if ~isnan(RBTStAverage)
    yline(RBTStAverage,'r');
end
axis([-0.5 1.5 min(RBTSScore)-0.5 max(RBTSScore)+0.5]);
title('RBTS score'); 


%% random, n=3
clearvars;
[x,y] = randomAgents(100);
BTSScore_dummy = BTSScore_dummy(x,y);
RBTSScore = RBTSScore(x,y);

[BTSDummyResult,~,BTSDummyScoreOutput,BTSDummytAverage,BTSDummyfAverage] ...
                            = determinationModel1(x,BTSScore_dummy);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = determinationModel1(x,RBTSScore);
                        
%% plotting
figure('Name','randomAgents, n=3');
hold on;
subplot(3,1,1);
scatter(x,y);
axis([-0.5 1.5 0 1]);
title('Prediction Report (y)');  


subplot(3,1,2);
scatter(x,BTSScore_dummy);
if ~isnan(BTSDummyfAverage)
    yline(BTSDummyfAverage,'b');
end
if ~isnan(BTSDummytAverage)
    yline(BTSDummytAverage,'r');
end
axis([-0.5 1.5 min(BTSScore_dummy)-0.5 max(BTSScore_dummy)+0.5]);
title('BTS score with dummy agents'); 

subplot(3,1,3);
scatter(x,RBTSScore);
if ~isnan(RBTSfAverage)
    yline(RBTSfAverage,'b');
end
if ~isnan(RBTStAverage)
    yline(RBTStAverage,'r');
end
axis([-0.5 1.5 min(RBTSScore)-0.5 max(RBTSScore)+0.5]);
title('RBTS score'); 
