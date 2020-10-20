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


%% expected payoff x=1
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

%% expected payoff x<1
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

x = xlabel("$s_i$", 'FontSize', 13);
set(x ,'Interpreter','latex');
y = ylabel("expected payoff",'FontSize', 13);
set(y ,'Interpreter','latex');