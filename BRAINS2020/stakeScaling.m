%% reward
% this plot shows the expected reward proportion out of the total available
% reward the adversarial player retrieve
% Note: assume that all top-ranked voters have the same score therefore
% replicated identity doesn't decrease the chance of other voters receiving
% the reward
x=1:0.1:30;
N=30;
cleanPlot('Stake Scaling Scheme - reward proportion');
hold on;

x1=x./(x+30);
plot(x1, (x.^2 ./ (x.^2 + N)), 'k-');
plot(x1, (0.9*x.^2 + 0.1*x) ./ (0.9*x.^2 + 0.1*x + N), 'k-.');
plot(x1, (0.5*x.^2 + 0.5*x) ./ (0.5*x.^2 + 0.5*x + N), 'k--');
plot(x1, (0.1*x.^2 + 0.9*x) ./ (0.1*x.^2 + 0.9*x + N), 'k:');
plot(x1, (x ./ (x + N)), 'k-','LineWidth', 1.5);

hl = legend('$\beta=1$','$\beta=0.9$','$\beta=0.5$','$\beta=0.1$', '$\beta=0$', 'FontSize', 13);
set(hl ,'Interpreter','latex');
x = xlabel("Portion of stake controlled by voter $i$", 'FontSize', 13);
set(x ,'Interpreter','latex');
y = ylabel("Noramlized reward share",'FontSize', 13);
set(y ,'Interpreter','latex');

% can manipulate the optimal point of reward by adjusting the reward
% scaling function

%% reward
% this plot shows the expected reward proportion out of the total available
% reward the adversarial player retrieve
% Note: assume that all top-ranked voters have the same score therefore
% replicated identity doesn't decrease the chance of other voters receiving
% the reward
x=1:0.1:30;
N=30;
cleanPlot('Stake Scaling Scheme - reward proportion');
hold on;

x1=x./(x+30);
plot(x1, (x.^2 ./ (x.^2 + N)), 'k-');
plot(x1, (0.9*2*x.^2 ./(x+1) + 0.1*x) ./ (0.9*2*x.^2 ./(x+1) + 0.1*x + N), 'k-.');
plot(x1, (0.5*2*x.^2 ./(x+1) + 0.5*x) ./ (0.5*2*x.^2 ./(x+1) + 0.5*x + N), 'k--');
plot(x1, (0.1*2*x.^2 ./(x+1) + 0.9*x) ./ (0.1*2*x.^2 ./(x+1) + 0.9*x + N), 'k:');
plot(x1, (x ./ (x + N)), 'k-','LineWidth', 1.5);

hl = legend('$\beta=1$','$\beta=0.9$','$\beta=0.5$','$\beta=0.1$', '$\beta=0$', 'FontSize', 13);
set(hl ,'Interpreter','latex');
x = xlabel("Portion of stake controlled by voter $i$", 'FontSize', 13);
set(x ,'Interpreter','latex');
y = ylabel("Noramlized reward share",'FontSize', 13);
set(y ,'Interpreter','latex');

% can manipulate the optimal point of reward by adjusting the reward
% scaling function

%% reward
% assume total of 30 voters are rewarded
x=1:0.1:10;
N=10;
cleanPlot('Stake Scaling Scheme - reward proportion');
hold on;
%plot(x, (x.^2)./(x+10)+1, 'color', 'r');
%plot(x, sqrt(x), 'color', 'b');
plot(x, (x.^2 ./ (N-x+x.^2)), 'color', 'r');
plot(x, (0.5*x.^2 + 0.5) ./ (N-(x+0.5*x.^2 + 0.5)), 'color', 'g');
plot(x, (2*x.^2 ./(x+1)) ./ (N-(x+2*x.^2 ./(x+1))), 'color', 'k');
plot(x, (x ./ (N)), 'color', 'b');
%plot(x, log(x)+x, 'color', 'g');

hl=legend('scaling with x^2','scaling with 0.5x^2+0.5','2*x^2/(x+1)','linear scaling', 'FontSize', 13);
set(hl ,'Interpreter','latex');
xlabel("stake (in terms of minimum stake)", 'FontSize', 13);
ylabel("reward portion out of total reward",'FontSize', 13);

% can manipulate the optimal point of reward by adjusting the reward
% scaling function

%% voting power
% assume there are 30 other voters
x=1:0.1:30;
N=30;
cleanPlot('Stake Scaling Scheme - voting power');
hold on;

x1=x./(x+30);
plot(x1, sqrt(x) ./ (sqrt(x) + N), 'k-');
plot(x1, (0.9*sqrt(x) + 0.1*x) ./ (0.9*sqrt(x) + 0.1*x + N), 'k-.');
plot(x1, (0.5*sqrt(x) + 0.5*x) ./ (0.5*sqrt(x) + 0.5*x + N), 'k--');
plot(x1, (0.1*sqrt(x) + 0.9*x) ./ (0.1*sqrt(x) + 0.9*x + N), 'k:');
plot(x1, (x ./ (x + N)), 'k-','LineWidth', 1.5);

hl = legend('$\alpha=1$','$\alpha =0.9$', '$\alpha=0.5$','$\alpha=0.1$','$\alpha=0$', 'FontSize', 13)
set(hl ,'Interpreter','latex');
x = xlabel("Portion of stake controlled by voter $i$", 'FontSize', 13);
set(x ,'Interpreter','latex');
y = ylabel("Normalized voting weight",'FontSize', 13);
set(y ,'Interpreter','latex');


%% voting power
% assume 30 total votes are allowed
x=1:0.1:30;
N=30;
cleanPlot('Stake Scaling Scheme - voting power');
hold on;

plot(x, sqrt(x) ./ (N), 'color', 'r');
plot(x, (0.5*sqrt(x) + 0.5*x) ./ (N), 'color', 'g');
plot(x, (x ./ (N)), 'color', 'b');

legend('scaling with sqrt(x)','average of sqrt and linear', 'linear scaling', 'FontSize', 13)
xlabel("stake (in terms of minimum stake)", 'FontSize', 13);
ylabel("voting power",'FontSize', 13);


%% possibility on the wining side 

clearvars;
N = 30; % 30 other voters in the system staking unit stakes
PrTrue = 0.3;
s=1:1:30; % stake of the voter of interest
gs = sqrt(s);

%ignore the case where there is a draw
pH = 1-(binocdf((N-s)/2, N, PrTrue));
pHs = 1-(binocdf((N-gs)/2, N, PrTrue));

pL = (binocdf((N-s)/2, N, PrTrue));
pLs = (binocdf((N-gs)/2, N, PrTrue));

cleanPlot('Prob on the winning side');
hold on;

plot(s, pHs, 'color', 'b');
plot(s, pH, 'color', 'r');

legend('scaling with sqrt(x)', 'linear scaling', 'FontSize', 13)
xlabel("stake (in terms of minimum stake)", 'FontSize', 13);
ylabel("prob on the winning side",'FontSize', 13);

%% expected payoff
clearvars;
N = 30; % 30 other voters in the system staking unit stakes
PrTrue = 0.1;
r=0.2;
b=100;
C = 0.1; % fixed cost
c = 0.5; % variable cost
uH = 50;
uL=0;

s=1:1:30; % stake of the voter of interest
gs = sqrt(s);
gs1 = (0.5*sqrt(s) + 0.5*s);

%ignore the case where there is a draw
pH = 1-(binocdf((N-s)/2, N, PrTrue));
pHs = 1-(binocdf((N-gs)/2, N, PrTrue));
pHs1 = 1-(binocdf((N-gs1)/2, N, PrTrue));

pL = (binocdf((N-s)/2, N, PrTrue));
pLs = (binocdf((N-gs)/2, N, PrTrue));
pLs1 = (binocdf((N-gs1)/2, N, PrTrue));

fs = s.^2;
fs1 = (0.5*s.^2 + 0.5);
singleReport = pHs * uH + pLs * uL + ...
                r*b*(fs ./ (fs + N)) - C - c;
singleReport1 = pHs1 * uH + pLs1 * uL + ...
                r*b*(fs ./ (fs + N)) - C - c;
singleReport2 = pHs * uH + pLs * uL + ...
                r*b*(fs1 ./ (fs1 + N)) - C - c;  
multipleReports = pH * uH + pL * uL + ...
                r*b*(s ./ (s + N)) - C - c*(s-1);
            
cleanPlot('Expected payoff');
hold on;

plot(s, singleReport, 'color', 'b');
plot(s, singleReport1, 'color', 'g');
plot(s, singleReport2, 'color', 'y');
plot(s, multipleReports, 'color', 'r');


legend('single report', 'single report1','single report2','multiple reports', 'FontSize', 13)
xlabel("stake (in terms of minimum stake)", 'FontSize', 13);
ylabel("expected payoff",'FontSize', 13);

%% expected payoff
clearvars;
N = 30; % 30 other voters in the system staking unit stakes
PrTrue = 0.45; %0.1,45
r=1;
b=10;
C = 0.1; % fixed cost
c = 0.3; % variable cost
uH = 50; %50, 
uL=0;

s=1:1:30; % stake of the voter of interest
gs = sqrt(s);
gs1 = (0.5*sqrt(s) + 0.5*s);
gs2 = (0.9*sqrt(s) + 0.1*s);

%ignore the case where there is a draw
pH = 1-(binocdf((N-s)/2, N, PrTrue));
pHs = 1-(binocdf((N-gs)/2, N, PrTrue));
pHs1 = 1-(binocdf((N-gs1)/2, N, PrTrue));
pHs2 = 1-(binocdf((N-gs2)/2, N, PrTrue));

pL = (binocdf((N-s)/2, N, PrTrue));
pLs = (binocdf((N-gs)/2, N, PrTrue));
pLs1 = (binocdf((N-gs1)/2, N, PrTrue));
pLs2 = (binocdf((N-gs2)/2, N, PrTrue));

fs = s.^2;
fs1 = 0.5*s.^2 + 0.5*s;
fs2 = 0.1*s.^2 + 0.9*s;
singleReport = pHs1 * uH + pLs1 * uL + ...
                r*b*(fs ./ (fs + N)) - C; % 0.5x1
singleReport1 = pHs1 * uH + pLs1 * uL + ...
                r*b*(fs1 ./ (fs1 + N)) - C; % 0.5x0.5  
singleReport2 = pHs1 * uH + pLs1 * uL + ...
                r*b*(fs2 ./ (fs2 + N)) - C; % 0.5x0.1
singleReport3 = pHs * uH + pLs * uL + ...
                r*b*(fs1 ./ (fs1 + N)) - C; % 1x0.5
singleReport4 = pHs2 * uH + pLs2 * uL + ...
                r*b*(fs2 ./ (fs2 + N)) - C; % 0.9x0.1
multipleReports = pH * uH + pL * uL + ...
                r*b*(s ./ (s + N)) - C - c*(s-1);
          
cleanPlot('Expected payoff');
hold on;

plot(s, smooth(singleReport), 'k--');
plot(s, smooth(singleReport1), 'k:');
plot(s, smooth(singleReport2), 'k-.');
plot(s, smooth(singleReport3), 'Color', [0.8,0.8,0.8]);
plot(s, smooth(singleReport4), 'color', 'k');
plot(s, smooth(multipleReports), 'k-','LineWidth', 1.5);


hl = legend('$\alpha=0.5, \beta=1$', '$\alpha=0.5, \beta=0.5$','$\alpha=0.5, \beta=0.1$','$\alpha=1, \beta=0.5$','$\alpha=0.9, \beta=0.1$', 'Multiple reports', 'FontSize', 9);
set(hl,'Interpreter','latex');

x = xlabel("$s_i$", 'FontSize', 13);
set(x ,'Interpreter','latex');
y = ylabel("expected payoff",'FontSize', 13);
set(y ,'Interpreter','latex');

%% expected payoff
clearvars;
N = 30; % 30 other voters in the system staking unit stakes
PrTrue = 0.45;
r=0.1;
b=10;
C = 0.1; % fixed cost
c = 0.3; % variable cost
uH = 10;
uL=0;

s=1:1:30; % stake of the voter of interest
gs = sqrt(s);
gs1 = (0.5*sqrt(s) + 0.5*s);
gs2 = (0.9*sqrt(s) + 0.1*s);

%ignore the case where there is a draw
pH = 1-(binocdf((N-s)/2, N, PrTrue));
pHs = 1-(binocdf((N-gs)/2, N, PrTrue));
pHs1 = 1-(binocdf((N-gs1)/2, N, PrTrue));
pHs2 = 1-(binocdf((N-gs2)/2, N, PrTrue));

pL = (binocdf((N-s)/2, N, PrTrue));
pLs = (binocdf((N-gs)/2, N, PrTrue));
pLs1 = (binocdf((N-gs1)/2, N, PrTrue));
pLs2 = (binocdf((N-gs2)/2, N, PrTrue));

fs = s.^2;
fs1 = 0.5*s.^2 + 0.5*s;
fs2 = 0.1*s.^2 + 0.9*s;
singleReport = pHs1 * uH + pLs1 * uL + ...
                r*b*(fs ./ (fs + N*r -1)) - C; % 0.5x1
singleReport1 = pHs1 * uH + pLs1 * uL + ...
                r*b*(fs1 ./ (fs1 + N*r -1)) - C; % 0.5x0.5  
singleReport2 = pHs1 * uH + pLs1 * uL + ...
                r*b*(fs2 ./ (fs2 + N*r -1)) - C; % 0.5x0.1
singleReport3 = pHs * uH + pLs * uL + ...
                r*b*(fs1 ./ (fs1 + N*r -1)) - C; % 1x0.5
singleReport4 = pHs2 * uH + pLs2 * uL + ...
                r*b*(fs2 ./ (fs2 + N*r -1)) - C; % 0.9x0.1
multipleReports = pH * uH + pL * uL + ...
                r*b*(min(s,(N+s)*r) ./ ((N+s)*r)) - C - c*(s-1);
          
cleanPlot('Expected payoff');
hold on;

plot(s, smooth(singleReport), 'k--');
plot(s, smooth(singleReport1), 'k:');
plot(s, smooth(singleReport2), 'k-.');
plot(s, smooth(singleReport3), 'Color', [0.8,0.8,0.8]);
plot(s, smooth(singleReport4), 'color', 'k');
plot(s, smooth(multipleReports), 'k-','LineWidth', 1.5);


hl = legend('$\alpha=0.5, \beta=1$', '$\alpha=0.5, \beta=0.5$','$\alpha=0.5, \beta=0.1$','$\alpha=1, \beta=0.5$','$\alpha=0.9, \beta=0.1$', 'Multiple reports', 'FontSize', 9);
set(hl ,'Interpreter','latex');

xlabel("s_i", 'FontSize', 13);
ylabel("expected payoff",'FontSize', 13);