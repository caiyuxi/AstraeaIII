% payoff analysis

%% model 1
% variation of expected scores given voters are all honest and based on the
% two state one signal model

% fix the probability, vary the number of voters
PrT1 = 0.5; % equal probability of two states
PrStT1 = 0.8; % first state has a higher belief in true signal
PrStT2 = 0.1;
PrTrue = 0.2; % each agents has a probability of 0.7 to receive a true signal

n = 3:50;
[expectedScoreSt,expectedScoreSf, PrTrueAsMajority] = ...
        ExpectedScore_singleSignal(PrT1,PrStT1,PrStT2,PrTrue,n);

figure('Name','Expected score for True-voting and False-voting agents');
subplot(2,1,1);
hold on;
plot(n,expectedScoreSt);
plot(n,expectedScoreSf);
xlabel("n, number of voters");
ylabel("u, expected score");
legend('expected score for True-voting voter', 'expected score for False-voting voter');

subplot(2,1,2);
plot(n,PrTrueAsMajority);
xlabel("n, number of voters");
ylabel("prob. for T to be majority");

% expected payoff is meaningless in this case since T score is strictly
% higher than F score
    
%% noisy source of signal

% fix the probability, vary the number of voters
PrT1 = 0.5; % equal probability of two states
PrStT1 = 0.8; % first state has a higher belief in true signal
PrStT2 = 0.1;
PrTrue = 0.51; % each agents has a probability of 0.7 to receive a true signal

n = 3:50;
[expectedScoreSt,expectedScoreSf, PrTrueAsMajority] = ...
        ExpectedScore_singleSignal(PrT1,PrStT1,PrStT2,PrTrue,n);

figure('Name','Expected score for True-voting and False-voting agents');
subplot(2,1,1);
hold on;
plot(n,expectedScoreSt);
plot(n,expectedScoreSf);
xlabel("n, number of voters");
ylabel("u, expected score");
legend('expected score for True-voting voter', 'expected score for False-voting voter');

subplot(2,1,2);
plot(n,PrTrueAsMajority);
xlabel("n, number of voters");
ylabel("prob. for T to be majority");


%%
% fix the number of voters and the belief model, vary the signal probability
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT1 = 0.1; % first state has a higher belief in true signal
PrStT2 = 0.4; %0.8,0.1; 0.8, 0.6; 0.1, 0.4
n=20;

PrTrue = 0.1:0.01:0.9;
for i = 1:length(PrTrue)
    [expectedScoreSt(i),expectedScoreSf(i), PrTrueAsMajority(i),PrFalseAsMajority(i)] = ...
            ExpectedScore_singleSignal(PrT1,PrStT1,PrStT2,PrTrue(i),n);
end

cleanPlot('Expected score for True-voting and False-voting agents');
subplot(2,1,1);
hold on;
plot(PrTrue,expectedScoreSt, 'k');
text(0.6,expectedScoreSt(70),'expected score of T-voter','FontSize', 10);
plot(PrTrue,expectedScoreSf, 'k');
text(0.6,expectedScoreSf(70),'expected score of F-voter','FontSize', 10);
xlabel("prob. to vote for T", 'FontSize', 13);
ylabel("expected RBTS score",'FontSize', 13);
grid on;

subplot(2,1,2);
hold on;
plot(PrTrue,PrTrueAsMajority, 'k');
text(0.7,PrTrueAsMajority(70)+0.05,'T as majority','FontSize', 10);

plot(PrTrue,PrFalseAsMajority, 'k');
text(0.7,PrFalseAsMajority(70)+0.05,'F as majority','FontSize', 10);
xlabel("prob. to vote for T", 'FontSize', 13);
ylabel("prob. to be output", 'FontSize', 13);
grid on;
%% expected payoff
% assume max reward and max penalty are both 1
r = 1;
p = -1;


for i = 1:length(PrTrue)
    if expectedScoreSt(i)>expectedScoreSf(i)
        tExpectedPayoff(i) = r;
        fExpectedPayoff(i) = p;
    elseif expectedScoreSt(i)<expectedScoreSf(i)
        tExpectedPayoff(i) = p;
        fExpectedPayoff(i) = r;
    end
end
cleanPlot('Expected payoff for True-voting and False-voting agents');
plot(PrTrue,tExpectedPayoff, '-k');
text(0.6,tExpectedPayoff(70)-0.1,'expected payoff of True-voting voter','FontSize', 10);
plot(PrTrue,fExpectedPayoff, '--k');
text(0.6,fExpectedPayoff(70)+0.1,'expected payoff of False-voting voter','FontSize', 10);

xlabel("probability of T to be received", 'FontSize', 13);
ylabel("expected payoff",'FontSize', 13);

%% adversarial scenario
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT1 = 0.1; % first state has a higher belief in true signal
PrStT2 = 0.2;
n=30;
PrTrue = 0.9;

p = 0:0.1:1;
for i = 1:length(p)
    [expectedScoreSt(i),expectedScoreSf(i), PrTrueAsMajority(i),PrFalseAsMajority(i)] = ...
            AdversarialAttack(PrT1,PrStT1,PrStT2,PrTrue,n, p(i));
end
cleanPlot('Expected score under adversarial attacks');
subplot(2,1,1);
hold on;
plot(p,expectedScoreSt, 'k');
text(0.6,expectedScoreSt(7)+0.1,'expected score of True-voting voter','FontSize', 10);
plot(p,expectedScoreSf, 'k');
text(0.6,expectedScoreSf(7)+0.1,'expected score of False-voting voter','FontSize', 10);

xlabel("ratio of votes controlled by adversary", 'FontSize', 13);
ylabel("u, expected score", 'FontSize', 13);
grid on;

subplot(2,1,2);
hold on;
plot(p,PrTrueAsMajority, 'k');
text(0.8,PrTrueAsMajority(7)+0.05,'true as majority','FontSize', 10);

plot(p,PrFalseAsMajority, 'k');
text(0.8,PrFalseAsMajority(7)+0.05,'false as majority','FontSize', 10);
xlabel("ratio of votes controlled by adversary", 'FontSize', 13);
ylabel("probability", 'FontSize', 13);
grid on;
%% lazy scenario
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT1 = 0.1; % first state has a higher belief in true signal
PrStT2 = 0.4;
n=30;
PrTrue = 0.9;
PrTrueAsMajority = [];
PrFalseAsMajority = [];

p = 0:0.05:1;
for i = 1:length(p)
    [expectedScoreSt(i),expectedScoreSf(i), PrTrueAsMajority(i),PrFalseAsMajority(i)] = ...
            LazyAttack(PrT1,PrStT1,PrStT2,PrTrue,n, p(i));
end
cleanPlot('Expected score with lazy voters');
subplot(2,1,1);
hold on;
p=n*p;
plot(p,expectedScoreSt, 'k');
text(0.6,expectedScoreSt(7)+0.1,'expected score of True-voting voter','FontSize', 10);
plot(p,expectedScoreSf, 'k');
text(0.6,expectedScoreSf(7)+0.1,'expected score of False-voting voter','FontSize', 10);

xlabel("ratio of votes controlled by lazy voters", 'FontSize', 13);
ylabel("u, expected score", 'FontSize', 13);
grid on;

subplot(2,1,2);
hold on;
plot(p,PrTrueAsMajority, 'k');
text(0.8,PrTrueAsMajority(7)+0.05,'true as majority','FontSize', 10);

plot(p,PrFalseAsMajority, 'k');
text(0.8,PrFalseAsMajority(7)+0.05,'false as majority','FontSize', 10);
xlabel("ratio of votes controlled by lazy voter", 'FontSize', 13);
ylabel("probability", 'FontSize', 13);
grid on;

%% multiple source - this is closer to the the system definition but has the same result as the previous one
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT1 = 0.9; % first state has a higher belief in true signal
PrStT2 = 0.2;
n=30;
PrTrueAsMajority = [];
PrFalseAsMajority = [];

PrSr1 = 0.1:0.01:0.9;
for i = 1:length(PrSr1)
    [expectedScoreSt(i),expectedScoreSf(i), PrTrueAsMajority(i),PrFalseAsMajority(i)] = ...
            ExpectedScore_singleSignal(PrT1,PrStT1,PrStT2,PrSr1(i),n);
end

cleanPlot('Expected score for True-voting and False-voting agents');
subplot(2,1,1);
hold on;
plot(PrSr1,expectedScoreSt, 'k');
text(0.6,expectedScoreSt(70),'expected score of T-voter','FontSize', 10);
plot(PrSr1,expectedScoreSf, 'k');
text(0.6,expectedScoreSf(70),'expected score of F-voter','FontSize', 10);
xlabel("prob. to vote for T", 'FontSize', 13);
ylabel("expected RBTS score",'FontSize', 13);
grid on;

subplot(2,1,2);
hold on;
plot(PrSr1,PrTrueAsMajority, 'k');
text(0.7,PrTrueAsMajority(70)+0.05,'T as majority','FontSize', 10);

plot(PrSr1,PrFalseAsMajority, 'k');
text(0.7,PrFalseAsMajority(70)+0.05,'F as majority','FontSize', 10);
xlabel("prob. to vote for T", 'FontSize', 13);
ylabel("prob. to be output", 'FontSize', 13);
grid on;

%% multiple signals
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT1 = 0.6; % first state has a higher belief in true signal
PrStT2 = 0.8;
n=30;
PrTrueAsMajority = [];
PrFalseAsMajority = [];

PrTrue = 0.1:0.01:0.9;
for i = 1:length(PrTrue)
    scoreDistribution = ...
            ExpectedScore_3Signal(PrT1,PrStT1,PrStT2,PrTrue(i),n);
    expectedScoreS3t(i) = scoreDistribution(1);
    expectedScoreS2t1f(i) = scoreDistribution(2);
    expectedScoreS1t2f(i) =  scoreDistribution(3);
    expectedScoreS3f(i) =  scoreDistribution(4); 
    PrTrueAsMajority(i) = scoreDistribution(5);
    PrFalseAsMajority(i) = scoreDistribution(6);
    Taverage(i) = scoreDistribution(7);
    Faverage(i) = scoreDistribution(8);
end

cleanPlot('Expected score for True-voting and False-voting agents');
subplot(2,1,1);
hold on;
plot(PrTrue,expectedScoreS3t, 'k');
text(0.6,expectedScoreS3t(70),'expected score of 3t T-voter','FontSize', 10);
plot(PrTrue,expectedScoreS2t1f, 'k');
text(0.6,expectedScoreS2t1f(70),'expected score of 2t1f F-voter','FontSize', 10);
plot(PrTrue,expectedScoreS1t2f, 'k');
text(0.6,expectedScoreS1t2f(70),'expected score of 1t2f F-voter','FontSize', 10);
plot(PrTrue,expectedScoreS3f, 'k');
text(0.6,expectedScoreS3f(70),'expected score of 3f F-voter','FontSize', 10);
plot(PrTrue,Faverage, 'b');
text(0.6,Faverage(70),'expected average score of F-voter','FontSize', 10);
plot(PrTrue,Taverage, 'r');
text(0.6,Taverage(70),'expected average score of T-voter','FontSize', 10);
xlabel("prob. to vote for T", 'FontSize', 13);
ylabel("expected RBTS score",'FontSize', 13);
grid on;

subplot(2,1,2);
hold on;
plot(PrTrue,PrTrueAsMajority, 'k');
text(0.7,PrTrueAsMajority(70)+0.05,'T as majority','FontSize', 10);

plot(PrTrue,PrFalseAsMajority, 'k');
text(0.7,PrFalseAsMajority(70)+0.05,'F as majority','FontSize', 10);
xlabel("prob. to vote for T", 'FontSize', 13);
ylabel("prob. to be output", 'FontSize', 13);
grid on;
