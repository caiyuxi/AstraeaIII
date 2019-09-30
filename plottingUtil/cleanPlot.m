function [] = cleanPlot(title)
%CLEANPLOT Summary of this function goes here
%   Detailed explanation goes here
figure('Name',title);
set(gcf,'color','w');
set(gca, 'FontName', 'Calibri');
hold on;
grid on;
end

