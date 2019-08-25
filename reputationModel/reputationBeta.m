function rep = reputationBeta(x,output)
% define the two parameter
    alphaH = 0.51;
    
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
    
    % expected value of the beta distribution
    for i = 1:length(x)
       rep(i) = (numSuc(i) + 1) / (numSuc(i) + numFal(i) + 2);
    end
    
    % store to the base ws
    assignin('base', 'rep', rep);
    assignin('base', 'numSuc', numSuc);
    assignin('base', 'numFal', numFal);
end

