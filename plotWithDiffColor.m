function plotWithDiffColor(x,y,bar)
    AB = [x' y'];
    % Find unique rows and corresponding indices
    [uniqueAB, ~, n] = unique(AB, 'rows');
    % Find number of occurrences
    nHist = hist(n, unique(n));
    mx = max(nHist);
    % Create colors for each number of occurrence
    colors = winter(mx);
    colormap(colors);
    % Construct a color matrix
    cMatrix = colors(nHist, :);
    % Create scatter plot
    scatter(uniqueAB(:, 1), uniqueAB(:, 2), 25, cMatrix);
    if bar == 1
        colormap(colors);
        cbh = colorbar; %Create Colorbar
        cbh.Ticks = linspace(1/(2*mx), 1-1/(2*mx), mx) ; %Create 8 ticks from zero to 1
        cbh.TickLabels = 1:mx ;
        %colorbar('YTick', linspace(1/(2*mx), 1-1/(2*mx), mx), ...
         %   'YTickLabel', 1:mx);
    end
end

