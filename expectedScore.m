% payoff analysis

%% model 1
% variation of expected scores given voters are all honest and based on the
% two state one signal model

% fix the probability, vary the number of voters
PrT1 = 0.5; % equal probability of two states
PrStT1 = 0.8; % first state has a higher belief in true signal
PrStT2 = 0.1;
PrTrue = 0.7; % each agents has a probability of 0.7 to receive a true signal

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
PrStT1 = 0.8; % first state has a higher belief in true signal
PrStT2 = 0.1;
n=20;

PrTrue = 0.1:0.1:0.9;
for i = 1:length(PrTrue)
    [expectedScoreSt(i),expectedScoreSf(i), PrTrueAsMajority(i)] = ...
            ExpectedScore_singleSignal(PrT1,PrStT1,PrStT2,PrTrue(i),n);
end

figure('Name','Expected score for True-voting and False-voting agents');

subplot(2,1,1);
hold on;
plot(PrTrue,expectedScoreSt);
plot(PrTrue,expectedScoreSf);
legend('expected score for True-voting voter', 'expected score for False-voting voter');
xlabel("probability of T to be received");
ylabel("u, expected score");

subplot(2,1,2);
plot(PrTrue,PrTrueAsMajority);
xlabel("probability of T to be received");
ylabel("prob. for T to be majority");