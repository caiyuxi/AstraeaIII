% accuracy analysis of the prediction score
clearvars;
N=30; % honest voter
a = 0:0.1:1; % adversarial portion
c = 0.5:0.1:1; % consider MPPO = 1

for i = 1:length(a)
    for j = 1:length(c)
        numTrueReport = round(N * (1-a(i)) * c(j));
        numFalseReport = round(N * (1-a(i)) * c(j) + N * a(i));

        % the reference ratio used for calculating the prediction score
        % note that since the current voter is excluded from the reference ratio of
        % true reports, the reference ratio is different for t/f voters
        trueTRatio = (numTrueReport - 1)/(N-1);
        falseTRatio = (numTrueReport)/(N-1);
        % error rate for prediction score
        % we want to maximize the prediction score when ratio = tRatio
        tError(i,j) = (c(j) - trueTRatio)^2; 
        fError(i,j) = (c(j) - falseTRatio)^2; 
    end
end

%% 3d plot
cleanPlot3d('Error in prediction score for True-voting and False-voting agents');
false = surf(c,a,fError, 'facecolor', [0.7 0.7 0.7], 'EdgeColor', 'none');
hold on;
true = surf(c,a,tError, 'facecolor',[0.3 0.3 0.3], 'EdgeColor', 'none');
set(gcf, 'Renderer', 'opengl');
legend([false, true], {'False-voter', 'True-voter'});

ylabel("number of voter",'FontSize', 13);
xlabel("c",'FontSize', 13);
zlabel("squared error for prediction score",'FontSize', 13);

%% 2d plots 
cleanPlot('squared error for prediction score, c=0.7');
hold on;
for j = 1:length(c)
    plot(a, tError(:,j), 'color', 'r');
    plot(a, fError(:,j), 'color', 'b');
end 

legend('True-voter','False-voter', 'FontSize', 13)
xlabel("number of voter", 'FontSize', 13);
ylabel("squared error for prediction score",'FontSize', 13);

%% at a particular c value
clearvars;
c = 0.6;
N=30; % honest voter
a = 0:0.1:1; % adversarial portion

for i = 1:length(a)
    numTrueReport = round(N * (1-a(i)) * c);
    numFalseReport = round(N * (1-a(i)) * c + N * a(i));

    trueTRatio = (numTrueReport - 1)/(N-1);
    falseTRatio = (numTrueReport)/(N-1);
    tError(i) = (c - trueTRatio)^2; 
    fError(i) = (c - falseTRatio)^2; 
end

cleanPlot('squared error for prediction score, c=0.7');
hold on;
plot(a.*N, tError, 'color', 'r');
plot(a.*N, fError, 'color', 'b');

legend('True-voter','False-voter', 'FontSize', 13)
xlabel("number of adversarial voter", 'FontSize', 13);
ylabel("distortion of prediction score for honest voter",'FontSize', 13);