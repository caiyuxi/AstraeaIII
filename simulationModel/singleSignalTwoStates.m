% assumption: every agent receives exactly one signal (S = T/F) before reporting,
% there are two internal states (T1,T2) each associated with different
% probability of receiving a t signal
function [x,y] = singleSignalTwoStates(n)
    PrT2 = 0.7;
    PrT1 = 0.3;
    PrStT1 = 0.1;
    PrSfT1 = 1 - PrStT1;
    PrStT2 = 0.8;
    PrSfT2 = 1 - PrStT2;

    PrSt = PrStT1 * PrT1 + PrStT2 * PrT2;
    PrT1St = (PrStT1 * PrT1) / PrSt;
    PrT2St = (PrStT2 * PrT2) / PrSt;

    PrSf = PrSfT1 * PrT1 + PrSfT2 * PrT2;
    PrT1Sf = (PrSfT1 * PrT1) / PrSf;
    PrT2Sf = (PrSfT2 * PrT2) / PrSf;

    % ySt is the t adoption prediction by an agent that has received a t signal
    ySt = PrStT1 * PrT1St + PrStT2 * PrT2St;
    ySf = PrStT1 * PrT1Sf + PrStT2 * PrT2Sf;


    % use rand, PrT2 and PrT1 to randomly determine the initial state of the
    % agent
    raw = rand(1,n);
    initState = arrayfun(@(x) selectState(x,PrT1), raw);

    raw = rand(1,n);
    signal = selectSignalArray(raw, initState, PrStT1, PrStT2);

    % truthful report
    x = signal;
    y = arrayfun(@(x) selectPrediction(x, ySt, ySf), signal);
end
% helper function
function prediction = selectPrediction(signal, ySt, ySf) 
    if signal == 1 
        prediction = ySt;
    else
        prediction = ySf;
    end
end

function signalArray = selectSignalArray(raw, state, PrStT1, PrStT2)
    signalArray = zeros(1,length(raw));
    for i = 1:length(raw)
        signalArray(i) = selectSignal(raw(i), state(i), PrStT1, PrStT2);
    end
end

% 1: t; 0: f
function signal = selectSignal(raw, state, PrStT1, PrStT2)
    if state == 1
        if raw <= PrStT1
            signal = 1;
        else
            signal = 0;
        end
    else
        if raw <= PrStT2
            signal = 1;
        else
            signal = 0;
        end
    end
end

function state = selectState(raw, PrT1)
    if raw <= PrT1
        state = 1;
    else
        state = 2;
    end
end