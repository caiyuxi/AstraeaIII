%% case 1: fix less-expected state
clearvars;
PrT1 = 0.5; % equal probability of two states
PrStT2 = 0.01;
n=30;

PrSr1 = 0.1:0.01:0.9;
PrStT1 = 0.1:0.01:0.9;
for i = 1:length(PrSr1)
    %for j = 1:length(PrStT1)
        %[expectedScoreSt(i,j),expectedScoreSf(i,j), PrTrueAsMajority(i,j),PrFalseAsMajority(i,j)] = ...
         %       ExpectedScore_notMaj(PrT1,PrSr1(j),PrStT2,PrSr1(i),n);
         [expectedScoreSt(i),expectedScoreSf(i), PrTrueAsMajority(i),PrFalseAsMajority(i)] = ...
                ExpectedScore_notMaj(PrT1,PrSr1(i),PrStT2,PrSr1(i),n);
    %end
end

cleanPlot3d('Expected score for True-voting and False-voting agents');
subplot(2,1,1);
%mesh(PrSr1,PrStT1,expectedScoreSf, 'edgecolor', [0.8 0.8 0.8]);
%text(0.6,expectedScoreSt(70),'expected score of T-voter','FontSize', 10);
%hold on;
%mesh(PrSr1,PrStT1,expectedScoreSt, 'edgecolor',[0.5 0.5 0.5]);
%text(0.6,expectedScoreSf(70),'expected score of F-voter','FontSize', 10);

plot(PrStT1, expectedScoreSt, 'color', 'r')
hold on;
plot(PrStT1, expectedScoreSf, 'color', 'b')
xlabel("prob. to vote for T", 'FontSize', 13);
%xlabel("state 1 prob. of T signal",'FontSize', 13);
%zlabel("expected RBTS score",'FontSize', 13);
ylabel("expected RBTS score",'FontSize', 13);

subplot(2,1,2);
%mesh(PrSr1,PrStT1,PrTrueAsMajority, 'edgecolor', 'r');
%text(0.7,PrTrueAsMajority(70)+0.05,'T as majority','FontSize', 10);
%hold on;
%mesh(PrSr1,PrStT1,PrFalseAsMajority, 'edgecolor', 'b');
%text(0.7,PrFalseAsMajority(70)+0.05,'F as majority','FontSize', 10);
%ylabel("prob. to vote for T", 'FontSize', 13);
xlabel("state 1 prob. of T signal",'FontSize', 13);
%zlabel("prob. to be output", 'FontSize', 13);
ylabel("prob. to be output", 'FontSize', 13);

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
PrStT2 = 0.8;
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
            LazyAttack_notMaj(PrT1,PrStT1,PrStT2,PrTrue(j),n, p(i));
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