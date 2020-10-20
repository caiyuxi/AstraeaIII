
for n = 3:100
    b = 0;
    for acc = 0:0.1:1
        b = b+1;
        y(n, b) = 1-sum(binopdf(1:floor(n/2),n,acc),'all');
    end
end

figure;
set(gcf,'color','w');
hold on;
x=4:100;
for b = 6:11
    p = fit(x', y(x,b).^2, 'exp2');
    plot(x,p(x), 'k');
    text(-5,p(5),strcat('c=', num2str((b-1)/10)),'FontSize', 13);
end
set(gca, 'FontName', 'Calibri');
title("Probability of correct oracle output",'FontSize', 13)
xlabel("Number of voters",'FontSize', 13);
ylabel("P_{Corr}",'FontSize', 13);
xlim([-5 100])
grid on;