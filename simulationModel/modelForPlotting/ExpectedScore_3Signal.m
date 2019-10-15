function [scoreDistribution] = ExpectedScore_3Signal(PrT1,PrStT1,PrStT2,PrTrue,n)
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
% prob of false signal in the beginning
PrSf = PrSfT1 * PrT1 + PrSfT2 * PrT2;

% prob of state 1
PrT1S3t = (PrStT1 * PrT1)^3 / PrSt^3; % Pr(State = T1 | Signal = TTT)
PrT1S2t1f = (PrStT1 * PrT1)^2 * (PrSfT1 * PrT1) / (PrSt^2 * PrSf); % Pr(State = T1 | Signal = TFT, FTT, TTF)
PrT1S1t2f = (PrStT1 * PrT1) * (PrSfT1 * PrT1)^2 / (PrSt * PrSf^2); % Pr(State = T1 | Signal = FFT, FTF, TFF)
PrT1S3f = (PrSfT1 * PrT1)^3 / PrSf^3; % Pr(State = T1 | Signal = FFF)


% prob of state 2
PrT2S3t = (PrStT2 * PrT2)^3 / PrSt^3; % Pr(State = T1 | Signal = TTT)
PrT2S2t1f = (PrStT2 * PrT2)^2 * (PrSfT2 * PrT2) / (PrSt^2 * PrSf); % Pr(State = T1 | Signal = TFT, FTT, TTF)
PrT2S1t2f = (PrStT2 * PrT2) * (PrSfT2 * PrT2)^2 / (PrSt * PrSf^2); % Pr(State = T1 | Signal = FFT, FTF, TFF)
PrT2S3f = (PrSfT2 * PrT2)^3 / PrSf^3; % Pr(State = T1 | Signal = FFF)

% ySt is the t adoption prediction by an agent that has received a t signal
yS3t = PrStT1 * PrT1S3t + PrStT2 * PrT2S3t;
yS2t1f = PrStT1 * PrT1S2t1f + PrStT2 * PrT2S2t1f;
yS1t2f = PrStT1 * PrT1S1t2f + PrStT2 * PrT2S1t2f;
yS3f = PrStT1 * PrT1S3f + PrStT2 * PrT2S3f;

% Signaling model: True signal with probability PrTrue, False signal with
% probability PrFalse
PrTrue = PrTrue;
PrFalse = 1-PrTrue;

% portion of population receiving the corresponding signals
Pr3t = PrTrue^3;
Pr2t1f = nchoosek(3,2) * PrTrue^2 * PrFalse;
Pr1t2f = nchoosek(3,2) * PrTrue * PrFalse^2;
Pr3f = PrFalse^3;
Prxt = Pr3t + Pr2t1f;
Prxf = Pr1t2f + Pr3f;

Prxt_T = (round(Prxt*n)-1) / n;
Prxt_F = Prxt;
Prxf_T = Prxf;
Prxf_F = (round(Prxf*n)-1) / n;

% In this case, the most possible truth is True since it has a higher
% signal probability
PrTrueAsMajority = 1-(binocdf(n/2, n, Prxt));
PrFalseAsMajority = 1-(binocdf(n/2, n, Prxf));

% recall that the modified RBTS scoring rule is: 
% u_i = |Report_T|/n * Rq(findYPrim(xi,yjT), xk) +  |Report_F|/n * Rq(findYPrim(xi,yjF), xk) + Rq(yi,xk)
    % xk: majority;
    % Report_T: the set of report with x = True;
    % Report_F: the set of report with x = False;
    % yjT: geometric average of y in Report_T/yi;
    % yjF: geometric average of y in Report_F/yi;
    
% The expected prediction report set by true-voter
yjT_Fvoter = GroundTo0(geomean([repelem(yS3t,round(Pr3t*n)), repelem(yS2t1f,round(Pr2t1f*n))])); 
yjT_3t = GroundTo0(geomean([repelem(yS3t,max(0,round(Pr3t*n)-1)), repelem(yS2t1f,round(Pr2t1f*n))])); %exclude one 3t report if current voter is 3t
yjT_2t1f = GroundTo0(geomean([repelem(yS3t,round(Pr3t*n)), repelem(yS2t1f,max(0,round(Pr2t1f*n)-1))])); %exclude one 2t1f report if current voter is 2t1f
% The expected prediction report set by false-voter
yjF_Tvoter = GroundTo0(geomean([repelem(yS3f,round(Pr3f*n)), repelem(yS1t2f,round(Pr1t2f*n))])); 
yjF_3f = GroundTo0(geomean([repelem(yS3f,max(0,round(Pr3f*n) - 1)), repelem(yS1t2f,round(Pr1t2f*n))])); %exclude one 3f report if current voter is 3f
yjF_1t2f = GroundTo0(geomean([repelem(yS3f,round(Pr3f*n)), repelem(yS1t2f,max(0,round(Pr1t2f*n) - 1))])); %exclude one 1t2f report if current voter is 1t2f

expectedScoreS3t = PrTrueAsMajority * ... % true as majority,xk=1
               ... %information score 
                        (Prxt_T * quadraticScoringRule(1,findYPrim(1,yjT_3t)) ...
                         + Prxf_T * quadraticScoringRule(1,findYPrim(1,yjF_Tvoter)) ...
               ... % prediction score
                        + quadraticScoringRule(1,yS3t)) ...
                + PrFalseAsMajority * ... % false as majority,xk=0
               ... %information score 
                        (Prxt_T * quadraticScoringRule(0,findYPrim(1,yjT_3t)) ...
                         + Prxf_T * quadraticScoringRule(0,findYPrim(1,yjF_Tvoter)) ...
               ... % prediction score
                         + quadraticScoringRule(0,yS3t)) ... 
                + (1 - PrTrueAsMajority - PrFalseAsMajority) * ... % if no majority, pick another voter as reference
               ... % the randomly picked voter votes for T
                       (Prxt_T * (Prxt_T * quadraticScoringRule(1,findYPrim(1,yjT_3t)) ...
                         + Prxf_T * quadraticScoringRule(1,findYPrim(1,yjF_Tvoter)) ...
                         + quadraticScoringRule(1,yS3t)) ...
               ... % the randomly picked voter votes for F
                      + Prxf_T * (Prxt_T * quadraticScoringRule(0,findYPrim(1,yjT_3t)) ...
                         + Prxf_T * quadraticScoringRule(0,findYPrim(1,yjF_Tvoter)) ...
                         + quadraticScoringRule(0,yS3t)));
                     

expectedScoreS2t1f = PrTrueAsMajority * ... % true as majority,xk=1
               ... %information score 
                        (Prxt_T * quadraticScoringRule(1,findYPrim(1,yjT_2t1f)) ...
                         + Prxf_T * quadraticScoringRule(1,findYPrim(1,yjF_Tvoter)) ...
               ... % prediction score
                        + quadraticScoringRule(1,yS2t1f)) ...
                + PrFalseAsMajority * ... % false as majority,xk=0
               ... %information score 
                        (Prxt_T * quadraticScoringRule(0,findYPrim(1,yjT_2t1f)) ...
                         + Prxf_T * quadraticScoringRule(0,findYPrim(1,yjF_Tvoter)) ...
               ... % prediction score
                         + quadraticScoringRule(0,yS2t1f)) ... 
                + (1 - PrTrueAsMajority - PrFalseAsMajority) * ... % if no majority, pick another voter as reference
               ... % the randomly picked voter votes for T
                       (Prxt_T * (Prxt_T * quadraticScoringRule(1,findYPrim(1,yjT_2t1f)) ...
                         + Prxf_T * quadraticScoringRule(1,findYPrim(1,yjF_Tvoter)) ...
                         + quadraticScoringRule(1,yS2t1f)) ...
               ... % the randomly picked voter votes for F
                      + Prxf_T * (Prxt_T * quadraticScoringRule(0,findYPrim(1,yjT_2t1f)) ...
                         + Prxf_T * quadraticScoringRule(0,findYPrim(1,yjF_Tvoter)) ...
                         + quadraticScoringRule(0,yS2t1f)));
                     
expectedScoreS3f = PrTrueAsMajority * ... % true as majority,xk=1
               ... %information score
                        (Prxt_F * quadraticScoringRule(1,findYPrim(0,yjT_Fvoter)) ...
                         + Prxf_F * quadraticScoringRule(1,findYPrim(0,yjF_3f)) ...
               ... % prediction score
                        + quadraticScoringRule(1,yS3f)) ...
                + PrFalseAsMajority * ... % false as majority,xk=0
               ... %information score 
                        (Prxt_F * quadraticScoringRule(0,findYPrim(0,yjT_Fvoter)) ...
                         + Prxf_F * quadraticScoringRule(0,findYPrim(0,yjF_3f)) ...
               ... % prediction score
                         + quadraticScoringRule(0,yS3f)) ... 
                + (1 - PrTrueAsMajority - PrFalseAsMajority) * ... % if no majority, pick another voter as reference
               ... % the randomly picked voter votes for T
                       (Prxt_F * (Prxt_F * quadraticScoringRule(1,findYPrim(0,yjT_Fvoter)) ...
                         + Prxf_F * quadraticScoringRule(1,findYPrim(0,yjF_3f)) ...
                         + quadraticScoringRule(1,yS3f)) ...
               ... % the randomly picked voter votes for F
                      + Prxf_F * (Prxt_F * quadraticScoringRule(0,findYPrim(0,yjT_Fvoter)) ...
                         + Prxf_F * quadraticScoringRule(0,findYPrim(0,yjF_3f)) ...
                         + quadraticScoringRule(0,yS3f))); 
                     
expectedScoreS1t2f = PrTrueAsMajority * ... % true as majority,xk=1
               ... %information score
                        (Prxt_F * quadraticScoringRule(1,findYPrim(0,yjT_Fvoter)) ...
                         + Prxf_F * quadraticScoringRule(1,findYPrim(0,yjF_1t2f)) ...
               ... % prediction score
                        + quadraticScoringRule(1,yS1t2f)) ...
                + PrFalseAsMajority * ... % false as majority,xk=0
               ... %information score 
                        (Prxt_F * quadraticScoringRule(0,findYPrim(0,yjT_Fvoter)) ...
                         + Prxf_F * quadraticScoringRule(0,findYPrim(0,yjF_1t2f)) ...
               ... % prediction score
                         + quadraticScoringRule(0,yS1t2f)) ... 
                + (1 - PrTrueAsMajority - PrFalseAsMajority) * ... % if no majority, pick another voter as reference
               ... % the randomly picked voter votes for T
                       (Prxt_F * (Prxt_F * quadraticScoringRule(1,findYPrim(0,yjT_Fvoter)) ...
                         + Prxf_F * quadraticScoringRule(1,findYPrim(0,yjF_1t2f)) ...
                         + quadraticScoringRule(1,yS1t2f)) ...
               ... % the randomly picked voter votes for F
                      + Prxf_F * (Prxt_F * quadraticScoringRule(0,findYPrim(0,yjT_Fvoter)) ...
                         + Prxf_F * quadraticScoringRule(0,findYPrim(0,yjF_1t2f)) ...
                         + quadraticScoringRule(0,yS1t2f))); 

scoreDistribution = [expectedScoreS3t,expectedScoreS2t1f,expectedScoreS1t2f,expectedScoreS3f, ...
                     PrTrueAsMajority, PrFalseAsMajority,...
                     (round(n*Pr3t)*expectedScoreS3t + round(n*Pr2t1f)*expectedScoreS2t1f)/(round(n*Pr3t)+round(n*Pr2t1f)), ...  
                     (round(n*Pr1t2f)*expectedScoreS1t2f + round(n*Pr3f)*expectedScoreS3f)/(round(n*Pr1t2f)+round(n*Pr3f))];
end

function array = GroundTo0(array)
    temp = isnan(array);
    array(temp) = 0;
end
