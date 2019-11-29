%% figure 1 3d graph with state 2 being the actual real world state
% comment: this plot is meaningless under the new protocol: this is not the
% expected score from the point of view of a voter, this is from the system
clearvars;
PrT1 = 0.5; % equal probability of two states to start with
n=30; % 30 voters

PrSr1 = 0.05:0.01:0.95; % actual real world signal probability
PrStT1 = 0.05:0.01:0.95; % state 1 true-signal probability
for i = 1:length(PrSr1)
    PrStT2 = PrSr1(i);
    for j = 1:length(PrStT1)
        [expectedScoreSt(i,j),expectedScoreSf(i,j), PrTrueAsMajority(i,j),PrFalseAsMajority(i,j)] = ...
                ExpectedScore_notMaj(PrT1,PrStT1(j),PrStT2,PrSr1(i),n);
    end
end

cleanPlot3d('Expected score for True-voting and False-voting agents');
false = surf(PrStT1,PrSr1,expectedScoreSf, 'facecolor', [0.7 0.7 0.7], 'EdgeColor', 'none');
hold on;
true = surf(PrStT1,PrSr1,expectedScoreSt, 'facecolor',[0.3 0.3 0.3], 'EdgeColor', 'none');
set(gcf, 'Renderer', 'opengl');
legend([false, true], {'False-voter', 'True-voter'});

ylabel("Pr(True)",'FontSize', 13);
xlabel("Pr(True|T=1)",'FontSize', 13);
zlabel("Expected Score",'FontSize', 13);



%% figure 1(2d version): fix Pr(True|T=1) at 0.5 and vary state 2 (the actual real world state)
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT1 = 0.6;
n=30;

PrSr1 = 0.1:0.01:0.9;
for i = 1:length(PrSr1)
    PrStT2 = PrSr1(i);
    [expectedScoreSt(i),expectedScoreSf(i), PrTrueAsMajority(i),PrFalseAsMajority(i)] = ...
         ExpectedScore_notMaj(PrT1,PrStT1,PrStT2,PrSr1(i),n);
end

cleanPlot('Expected score for True-voting and False-voting agents');
hold on;
plot(PrSr1, expectedScoreSt, 'color', 'r');
plot(PrSr1, expectedScoreSf, 'color', 'b');

legend('True-voter','False-voter', 'FontSize', 13)
xlabel("Pr(True) = Pr(True|T=2)", 'FontSize', 13);
ylabel("expected score",'FontSize', 13);

%% figure 3: adversary - not using this figure
% based on the behavior in figure 1, it is clear that adversary can
% manimulate the system easier in some prior while it is impossible to
% manipuate in the other. But if we assume the adversary is strong enough 
% (knows the behavior of the other voters), then they can simply switch 
% to the side with higher score. -> So I think it is unnecessary to have a
% figure on adversary. 
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT1 = 0.2;
n=30;

PrSr1 = 0.5:0.01:0.9;
p = 0:0.01:1;
for i = 1:length(PrSr1)
    PrStT2 = PrSr1(i);
    for j = 1:length(p)
        [expectedScoreSt(i,j),expectedScoreSf(i,j), PrTrueAsMajority(i,j),PrFalseAsMajority(i,j),expectedScoreAdv] = ...
             ExpectedScore_adversarial(PrT1,PrStT1,PrStT2,PrSr1(i),n, p(j));
    end
end

cleanPlot3d('Expected score for True-voting and False-voting agents');
false = surf(p,PrSr1,expectedScoreSf, 'facecolor', [0.7 0.7 0.7], 'EdgeColor', 'none');
hold on;
true = surf(p,PrSr1,expectedScoreSt, 'facecolor',[0.3 0.3 0.3], 'EdgeColor', 'none');
set(gcf, 'Renderer', 'opengl');
legend([false, true], {'False-voter', 'True-voter'});

ylabel("Pr(True)",'FontSize', 13);
xlabel("Adversary",'FontSize', 13);
zlabel("Expected Score",'FontSize', 13);

%%