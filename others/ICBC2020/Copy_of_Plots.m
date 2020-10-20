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

%% case 2: fix more-expected state
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT2 = 0.99;
n=30;

PrSr1 = 0.1:0.01:0.9;
PrStT1 = 0.1:0.01:0.9;
for i = 1:length(PrSr1)
    for j = 1:length(PrStT1)
        [expectedScoreSt(i,j),expectedScoreSf(i,j), PrTrueAsMajority(i,j),PrFalseAsMajority(i,j)] = ...
                ExpectedScore_notMaj(PrT1,PrStT1(j),PrStT2,PrSr1(i),n);
    end
end

cleanPlot3d('Expected score for True-voting and False-voting agents');
subplot(2,1,1);
mesh(PrSr1,PrStT1,expectedScoreSt, 'edgecolor', 'r');
%text(0.6,expectedScoreSt(70),'expected score of T-voter','FontSize', 10);
hold on;

mesh(PrSr1,PrStT1,expectedScoreSf, 'edgecolor', 'b');
%text(0.6,expectedScoreSf(70),'expected score of F-voter','FontSize', 10);
ylabel("prob. to vote for T", 'FontSize', 13);
xlabel("state 1 prob. of T signal",'FontSize', 13);
zlabel("expected RBTS score",'FontSize', 13);

subplot(2,1,2);
mesh(PrSr1,PrStT1,PrTrueAsMajority, 'edgecolor', 'r');
%text(0.7,PrTrueAsMajority(70)+0.05,'T as majority','FontSize', 10);
hold on;
mesh(PrSr1,PrStT1,PrFalseAsMajority, 'edgecolor', 'b');
%text(0.7,PrFalseAsMajority(70)+0.05,'F as majority','FontSize', 10);
ylabel("prob. to vote for T", 'FontSize', 13);
xlabel("state 1 prob. of T signal",'FontSize', 13);
zlabel("prob. to be output", 'FontSize', 13);

%% case 3: fix actual signal, vary state 1 and initial distribution over two states
clearvars;
 % equal probability of two states
PrStT2 = 0.99;
n=30;

PrStT1 = 0.1:0.01:0.9;
PrT1 = 0.1:0.01:0.9;
PrSr1 = 0.8;
for i = 1:length(PrStT1)
    for j = 1:length(PrT1)
        [expectedScoreSt(i,j),expectedScoreSf(i,j), PrTrueAsMajority(i,j),PrFalseAsMajority(i,j)] = ...
                ExpectedScore_singleSignal(PrT1(j),PrStT1(i),PrStT2,PrSr1,n);
    end
end

cleanPlot3d('Expected score for True-voting and False-voting agents');
subplot(2,1,1);
mesh(PrStT1,PrT1,expectedScoreSt, 'edgecolor', 'r');
%text(0.6,expectedScoreSt(70),'expected score of T-voter','FontSize', 10);
hold on;
mesh(PrStT1,PrT1,expectedScoreSf, 'edgecolor', 'b');
%text(0.6,expectedScoreSf(70),'expected score of F-voter','FontSize', 10);
xlabel("prob. to vote for T", 'FontSize', 13);
ylabel("state 1 prob. of T signal",'FontSize', 13);
zlabel("expected RBTS score",'FontSize', 13);

subplot(2,1,2);
mesh(PrStT1,PrT1,PrTrueAsMajority, 'edgecolor', 'r');
%text(0.7,PrTrueAsMajority(70)+0.05,'T as majority','FontSize', 10);
hold on;
mesh(PrStT1,PrT1,PrFalseAsMajority, 'edgecolor', 'b');
%text(0.7,PrFalseAsMajority(70)+0.05,'F as majority','FontSize', 10);
xlabel("prob. to vote for T", 'FontSize', 13);
ylabel("state 1 prob. of T signal",'FontSize', 13);
zlabel("prob. to be output", 'FontSize', 13);

%% lazy
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT1 = 0.1; % first state has a higher belief in true signal
PrStT2 = 0.8;
n=30;

PrTrueAsMajority = [];
PrFalseAsMajority = [];

PrTrue = 0:0.1:1;
p = 0:0.05:1;
for i = 1:length(p)
    for j = 1:length(PrTrue)
    [expectedScoreSt(i,j),expectedScoreSf(i,j), PrTrueAsMajority(i,j),PrFalseAsMajority(i,j)] = ...
            LazyAttack(PrT1,PrStT1,PrStT2,PrTrue(j),n, p(i));
    end
end
cleanPlot('Expected score with lazy voters');
subplot(2,1,1);
p=n*p;
mesh(PrTrue,p,expectedScoreSt, 'edgecolor', 'r');
hold on;
mesh(PrTrue,p,expectedScoreSf, 'edgecolor', 'b');
xlabel("prob. to vote for T", 'FontSize', 13);
ylabel("number of lazy voter",'FontSize', 13);
zlabel("expected RBTS score",'FontSize', 13);

%xlabel("ratio of votes controlled by lazy voters", 'FontSize', 13);
%ylabel("u, expected score", 'FontSize', 13);
%grid on;

subplot(2,1,2);
mesh(PrTrue,p,PrTrueAsMajority, 'edgecolor', 'r');
hold on;
mesh(PrTrue,p,PrFalseAsMajority, 'edgecolor', 'b');
xlabel("prob. to vote for T", 'FontSize', 13);
ylabel("number of lazy voter",'FontSize', 13);
zlabel("prob. for T to be output", 'FontSize', 13);

%% lazy 2
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT2 = 0.99;
PrTrue = 0.8;
n=30;

PrTrueAsMajority = [];
PrFalseAsMajority = [];

PrStT1 = 0:0.05:1;
p = 0:0.05:1;
for i = 1:length(p)
    for j = 1:length(PrStT1)
    [expectedScoreSt(i,j),expectedScoreSf(i,j), PrTrueAsMajority(i,j),PrFalseAsMajority(i,j)] = ...
            LazyAttack(PrT1,PrStT1(j),PrStT2,PrTrue,n, p(i));
    end
end
cleanPlot('Expected score with lazy voters');
subplot(2,1,1);
p=n*p;
mesh(PrStT1,p,expectedScoreSt, 'edgecolor', 'r');
hold on;
mesh(PrStT1,p,expectedScoreSf, 'edgecolor', 'b');
xlabel("prob. to receive T in state 1", 'FontSize', 13);
ylabel("number of lazy voter",'FontSize', 13);
zlabel("expected RBTS score",'FontSize', 13);

%xlabel("ratio of votes controlled by lazy voters", 'FontSize', 13);
%ylabel("u, expected score", 'FontSize', 13);
%grid on;

subplot(2,1,2);
mesh(PrStT1,p,PrTrueAsMajority, 'edgecolor', 'r');
hold on;
mesh(PrStT1,p,PrFalseAsMajority, 'edgecolor', 'b');
xlabel("prob. to receive T in state 1", 'FontSize', 13);
ylabel("number of lazy voter",'FontSize', 13);
zlabel("prob. for T to be output", 'FontSize', 13);

%% lazy 3
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT2 = 0.01;
PrTrue = 0.8;
n=30;

PrTrueAsMajority = [];
PrFalseAsMajority = [];

PrStT1 = 0:0.05:1;
p = 0:0.05:1;
for i = 1:length(p)
    for j = 1:length(PrStT1)
    [expectedScoreSt(i,j),expectedScoreSf(i,j), PrTrueAsMajority(i,j),PrFalseAsMajority(i,j)] = ...
            LazyAttack(PrT1,PrStT1(j),PrStT2,PrTrue,n, p(i));
    end
end
cleanPlot('Expected score with lazy voters');
subplot(2,1,1);
p=n*p;
mesh(PrStT1,p,expectedScoreSt, 'edgecolor', 'r');
hold on;
mesh(PrStT1,p,expectedScoreSf, 'edgecolor', 'b');
xlabel("prob. to receive T in state 1", 'FontSize', 13);
ylabel("number of lazy voter",'FontSize', 13);
zlabel("expected RBTS score",'FontSize', 13);

%xlabel("ratio of votes controlled by lazy voters", 'FontSize', 13);
%ylabel("u, expected score", 'FontSize', 13);
%grid on;

subplot(2,1,2);
mesh(PrStT1,p,PrTrueAsMajority, 'edgecolor', 'r');
hold on;
mesh(PrStT1,p,PrFalseAsMajority, 'edgecolor', 'b');
xlabel("prob. to receive T in state 1", 'FontSize', 13);
ylabel("number of lazy voter",'FontSize', 13);
zlabel("prob. for T to be output", 'FontSize', 13);