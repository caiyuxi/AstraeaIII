function [PrTrueAsMajority_herding,PrFalseAsMajority_herding, PrTrueAsMajority,PrFalseAsMajority] = MajorityVotingWithExpectation(PrT1,PrStT1,PrStT2,PrTrue,n)
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
PrTrue = PrTrue;
PrFalse = 1-PrTrue;

% In this case, the most possible truth is True since it has a higher
% signal probability
PrTrueAsMajority = 1-(binocdf(n/2, n, PrTrue));
PrFalseAsMajority = 1-(binocdf(n/2, n, PrFalse));

if ySt>=0.5 && ySf<=0.5 %no herding
    PrTrue = PrTrue;
    PrFalse = PrFalse;
elseif ySt>0.5 && ySf>0.5 %herding that all rational voters vote for true
    PrTrue = 1;
    PrFalse = 0;
elseif ySt<0.5 && ySf>0.5 % exact opposite of the signal, not likely to be possible
    PrTrue = PrFalse;
    PrFalse = 1-PrTrue;
else %herding that all rational voters vote for false
    PrTrue = 0;
    PrFalse = 1;
end
PrTrueAsMajority_herding = 1-(binocdf(n/2, n, PrTrue));
PrFalseAsMajority_herding = 1-(binocdf(n/2, n, PrFalse));
