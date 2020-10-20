function [outputArg1,outputArg2] = cleanPlot3d(title)
%CLEANPLOT3D Summary of this function goes here
%   Detailed explanation goes here
figure('Name',title);
set(gcf,'color','w');
set(gca, 'FontName', 'Calibri');
end

