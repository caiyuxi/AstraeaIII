
function [rep] = reputationTwoVar(x,output)
    % define the two parameter
    alphaH = 0.51;
    alphaL = 0.49;
    
    % retrieve the previously stored variables for calculating reputation,
    % initialize them if doesn't exist
    if evalin( 'base', 'exist(''numFal'',''var'') == 1' )
        numSuc = evalin('base', 'numSuc');
        numFal = evalin('base', 'numFal');
        rep = evalin('base', 'rep');
    else
        numSuc = zeros(size(x));
        numFal = zeros(size(x));
        rep = zeros(size(x));
        rep(size(x)) = 0.5;
    end

    success = (x==output);
    numSuc = numSuc + success;
    
    failure = 1.-success;
    numFal = numFal + failure;
    
    for i = 1:length(x)
       rep(i) = (rep(i)* alphaH^(numSuc(i)) * (1-alphaH)^(numFal(i)))...
                    / (rep(i)* alphaH^(numSuc(i)) * (1-alphaH)^(numFal(i))...
                       + (1-rep(i)) * alphaL^(numSuc(i)) * (1-alphaL)^(numFal(i)));
    end
    
    % store to the base ws
    assignin('base', 'rep', rep);
    assignin('base', 'numSuc', numSuc);
    assignin('base', 'numFal', numFal);
end

