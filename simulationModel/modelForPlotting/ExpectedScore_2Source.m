function [expectedScoreSt,expectedScoreSf, PrTrueAsMajority,PrFalseAsMajority] = ExpectedScore_2Source(PrT1,PrStT1,PrStT2,PrSr1,n)
% two states (T1, T2), chances for a voter to start in each state is as following
PrT1 = PrT1; % Pr(State = T1)
PrT2 = 1-PrT1; % Pr(State = T2)

% belief of signal possibility in each state
PrStT1 = PrStT1; % Pr(Signal = True | State = T1)
PrSfT1 = 1 - PrStT1; % Pr(Signal = False | State = T1)
PrStT2 = PrStT2; % Pr(Signal = True | State = T2)
PrSfT2 = 1 - PrStT2; % Pr(Signal = False | State = T2)

% prob of true signal in the beginning
PrSt = PrStT1 * PrT1 + PrStT2 * PrT2; % Pr(Signal = True)

% prob of each state given a true signal
PrT1St = (PrStT1 * PrT1) / PrSt; % Pr(State = T1 | Signal = True)
PrT2St = (PrStT2 * PrT2) / PrSt; % Pr(State = T2 | Signal = True)

% prob of false signal in the beginning
PrSf = PrSfT1 * PrT1 + PrSfT2 * PrT2;
% prob of each state given a false signal
PrT1Sf = (PrSfT1 * PrT1) / PrSf; % Pr(State = T1 | Signal = False)
PrT2Sf = (PrSfT2 * PrT2) / PrSf; % Pr(State = T2 | Signal = False)

% ySt is the t adoption prediction by an agent that has received a t signal
ySt = PrStT1 * PrT1St + PrStT2 * PrT2St;
ySf = PrStT1 * PrT1Sf + PrStT2 * PrT2Sf;

% Signaling model: True signal with probability PrTrue, False signal with
% probability PrFalse
PrTrue = PrSr1 * PrStT1 + (1-PrSr1) * PrStT2;
PrFalse = 1-PrTrue;

% In this case, the most possible truth is True since it has a higher
% signal probability
PrTrueAsMajority = 1-(binocdf(n/2, n, PrTrue));
PrFalseAsMajority = 1-(binocdf(n/2, n, PrFalse));

% recall that the modified RBTS scoring rule is: 
% u_i = |Report_T|/n * Rq(findYPrim(xk,yjT), xk) +  |Report_F|/n * Rq(findYPrim(xk,yjF), xk) + Rq(yi,xk)
    % xk: majority;
    % Report_T: the set of report with x = True;
    % Report_F: the set of report with x = False;
    % yjT: geometric average of y in Report_T/yi;
    % yjF: geometric average of y in Report_F/yi;
expectedScoreSt = PrTrueAsMajority * ... % true as majority
                        (PrTrue * quadraticScoringRule(1,findYPrim(1,ySt)) ...
                         + PrFalse * quadraticScoringRule(1,findYPrim(1,ySf)) ...
                         + quadraticScoringRule(1,ySt)) ... 
                + PrFalseAsMajority * ... % false as majority
                        (PrTrue * quadraticScoringRule(0,findYPrim(1,ySt)) ...
                         + PrFalse * quadraticScoringRule(0,findYPrim(1,ySf)) ...
                         + quadraticScoringRule(0,ySt)) ... 
                + (1 - PrTrueAsMajority - PrFalseAsMajority) * ... % if no majority, pick another voter as reference
                       (PrTrue * (PrTrue * quadraticScoringRule(1,findYPrim(1,ySt)) ...
                         + PrFalse * quadraticScoringRule(1,findYPrim(1,ySf)) ...
                         + quadraticScoringRule(1,ySt)) ...
                      + PrFalse * (PrTrue * quadraticScoringRule(0,findYPrim(1,ySt)) ...
                         + PrFalse * quadraticScoringRule(0,findYPrim(1,ySf)) ...
                         + quadraticScoringRule(0,ySt)));
expectedScoreSf = PrTrueAsMajority * ... % true as majority
                        (PrTrue * quadraticScoringRule(1,findYPrim(0,ySt)) ...
                         + PrFalse * quadraticScoringRule(1,findYPrim(0,ySf)) ...
                         + quadraticScoringRule(1,ySt)) ... 
                + PrFalseAsMajority * ... % false as majority
                        (PrTrue * quadraticScoringRule(0,findYPrim(0,ySt)) ...
                         + PrFalse * quadraticScoringRule(0,findYPrim(0,ySf)) ...
                         + quadraticScoringRule(0,ySt)) ... 
                + (1 - PrTrueAsMajority - PrFalseAsMajority) * ... % if no majority, pick another voter as reference
                       (PrTrue * (PrTrue * quadraticScoringRule(1,findYPrim(0,ySt)) ...
                         + PrFalse * quadraticScoringRule(1,findYPrim(0,ySf)) ...
                         + quadraticScoringRule(1,ySt)) ...
                      + PrFalse * (PrTrue * quadraticScoringRule(0,findYPrim(0,ySt)) ...
                         + PrFalse * quadraticScoringRule(0,findYPrim(0,ySf)) ...
                         + quadraticScoringRule(0,ySt)));  
                     

end

