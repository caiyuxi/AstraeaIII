n=13;
p=0.2;
PrTrue = 0.7;
PrFalse = 1-PrTrue;

PrTrueAsMajority = 0;
PrFalseAsMajority = 0;
minMaj = ceil(n/2);
lazyN = round(n*p);
honestN = n - lazyN;
for j = minMaj:n % #voter being the majority
    SubPrTrueAsMajority = 0;
    SubPrFalseAsMajority = 0;
    for i=0:lazyN % i is the number of lazy voters voting for T
        if j-i > honestN
            continue;
        end
        if i <= lazyN && j-i<=honestN
            SubPrTrueAsMajority = SubPrTrueAsMajority + (binopdf(i, lazyN, 0.5)) * (binopdf(j-i, honestN, PrTrue));
            SubPrFalseAsMajority = SubPrFalseAsMajority + (binopdf(i, lazyN, 0.5)) * (binopdf(j-i, honestN, PrFalse));
        elseif j-i<=n-lazyN
            %SubPrTrueAsMajority = SubPrTrueAsMajority + (binopdf(j, n-lazyN, PrTrue)) * binopdf(0, lazyN, 0.5);
            %SubPrFalseAsMajority = SubPrFalseAsMajority + (binopdf(j, n-lazyN, PrFalse)) * binopdf(0, lazyN, 0.5);
            %break;
            SubPrTrueAsMajority = SubPrTrueAsMajority + (binopdf(j, honestN, PrTrue));
            SubPrFalseAsMajority = SubPrFalseAsMajority + (binopdf(j, honestN, PrFalse));
            %break;
        elseif i<=lazyN
            %SubPrTrueAsMajority = SubPrTrueAsMajority + (1-binocdf(j, lazyN, 0.5)) * binopdf(0, n-lazyN, PrTrue);
            %SubPrFalseAsMajority = SubPrFalseAsMajority + (1-binocdf(j, lazyN, 0.5)) * binopdf(0, n-lazyN, PrFalse);
            %break;
            SubPrTrueAsMajority = SubPrTrueAsMajority + (binopdf(j, lazyN, 0.5));
            SubPrFalseAsMajority = SubPrFalseAsMajority + (binopdf(j, lazyN, 0.5));
            %break;
        else 
            x=1
        end
    end
    
    
    PrTrueAsMajority = PrTrueAsMajority + SubPrTrueAsMajority;
    PrFalseAsMajority = PrFalseAsMajority + SubPrFalseAsMajority;
end