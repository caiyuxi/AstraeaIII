%% singleSignalTwoStates, n=3
clearvars;
[x,y] = singleSignalTwoStates(3);
BTSScore_dummy = BTSScore_dummy(x,y);
RBTSScore = RBTSScore(x,y);

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
scatter(x,RBTSScore);
if ~isnan(RBTSfAverage)
    yline(RBTSfAverage,'b');
end
if ~isnan(RBTStAverage)
    yline(RBTStAverage,'r');
end
axis([-0.5 1.5 min(RBTSScore)-0.5 max(RBTSScore)+0.5]);
title('RBTS score'); 

%% singleSignalTwoStates, n=10
clearvars;
[x,y] = singleSignalTwoStates(10);
BTSScore_dummy = BTSScore_dummy(x,y);
RBTSScore = RBTSScore(x,y);

[BTSDummyResult,~,BTSDummyScoreOutput,BTSDummytAverage,BTSDummyfAverage] ...
                            = determinationModel1(x,BTSScore_dummy);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = determinationModel1(x,RBTSScore);

%% plotting
figure('Name','singleSignalTwoStates, n=10');
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
scatter(x,RBTSScore);
if ~isnan(RBTSfAverage)
    yline(RBTSfAverage,'b');
end
if ~isnan(RBTStAverage)
    yline(RBTStAverage,'r');
end
axis([-0.5 1.5 min(RBTSScore)-0.5 max(RBTSScore)+0.5]);
title('RBTS score'); 


%% singleSignalTwoStates, n=100
clearvars;
[x,y] = singleSignalTwoStates(100);
BTSScore_dummy = BTSScore_dummy(x,y);
RBTSScore = RBTSScore(x,y);

[BTSDummyResult,~,BTSDummyScoreOutput,BTSDummytAverage,BTSDummyfAverage] ...
                            = determinationModel1(x,BTSScore_dummy);
[RBTSResult,majOutput,RBTSScoreOutput,RBTStAverage,RBTSfAverage] ...
                            = determinationModel1(x,RBTSScore);

%% plotting
figure('Name','singleSignalTwoStates, n=10');
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
scatter(x,RBTSScore);
if ~isnan(RBTSfAverage)
    yline(RBTSfAverage,'b');
end
if ~isnan(RBTStAverage)
    yline(RBTStAverage,'r');
end
axis([-0.5 1.5 min(RBTSScore)-0.5 max(RBTSScore)+0.5]);
title('RBTS score'); 

