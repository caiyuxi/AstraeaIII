% accuracy analysis of the prediction score
clearvars;
n = 5:1:30;
c = 0:0.1:1;

for i = 1:length(n)
    for j = 1:length(c)
        numTrueReport = n(i) * c(j);
        numFalseReport = n(i) - numTrueReport;

        % the reference ratio used for calculating the prediction score
        % note that since the current voter is excluded from the reference ratio of
        % true reports, the reference ratio is different for t/f voters
        trueTRatio = (numTrueReport - 1)/(n(i)-1);
        falseTRatio = (numTrueReport)/(n(i)-1);
        % error rate for prediction score
        % we want to maximize the prediction score when ratio = tRatio
        tError(i,j) = (c(j) - trueTRatio)^2; 
        fError(i,j) = (c(j) - falseTRatio)^2; 
    end
end

%% 3d plot
cleanPlot3d('Error in prediction score for True-voting and False-voting agents');
false = surf(c,n,fError, 'facecolor', [0.7 0.7 0.7], 'EdgeColor', 'none');
hold on;
true = surf(c,n,tError, 'facecolor',[0.3 0.3 0.3], 'EdgeColor', 'none');
set(gcf, 'Renderer', 'opengl');
legend([false, true], {'False-voter', 'True-voter'});

ylabel("number of voter",'FontSize', 13);
xlabel("c",'FontSize', 13);
zlabel("squared error for prediction score",'FontSize', 13);

%% 2d plots 
cleanPlot('squared error for prediction score, c=0.7');
hold on;
for j = 1:length(c)
    plot(n, tError(:,j), 'color', 'r');
    plot(n, fError(:,j), 'color', 'b');
end 

legend('True-voter','False-voter', 'FontSize', 13)
xlabel("number of voter", 'FontSize', 13);
ylabel("squared error for prediction score",'FontSize', 13);

%% at a particular c value
clearvars;
c = 0.7;
n = 5:1:30;

for i = 1:length(n)
    numTrueReport = n(i) * c;
    numFalseReport = n(i) - numTrueReport;

    trueTRatio = (numTrueReport - 1)/(n(i)-1);
    falseTRatio = (numTrueReport)/(n(i)-1);

    tError(i) = (c - trueTRatio)^2; 
    fError(i) = (c - falseTRatio)^2; 
end

cleanPlot('squared error for prediction score, c=0.7');
hold on;
plot(n, tError, 'color', 'r');
plot(n, fError, 'color', 'b');

legend('True-voter','False-voter', 'FontSize', 13)
xlabel("number of voter", 'FontSize', 13);
ylabel("squared error for prediction score",'FontSize', 13);