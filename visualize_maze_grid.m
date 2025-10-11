function visualize_maze_grid(isWall, S, T)
% VISUALIZE_MAZE_GRID  Zobrazí bludiště (zdi vs. volno) se startem a cílem.
% (1,1) vlevo nahoře.
%
% isWall ... logická 5x5 (true=zeď)
% S, T   ... [r c] (volitelné; default [1,1] a [size, size])

    if nargin < 2 || isempty(S), S = [1,1]; end
    if nargin < 3 || isempty(T), T = [size(isWall,1), size(isWall,2)]; end

    n = size(isWall,1);
    img = ~isWall;  % 1 = volno, 0 = zeď (lepší kontrast)

    figure('Name','Bludiště 5x5 (půdorys mřížky)');
    imagesc(1:n, 1:n, img);
    axis equal tight; colormap(gray);
    set(gca,'YDir','reverse','XTick',1:n,'YTick',1:n);
    grid on; hold on;

    % Start (puntík) a cíl (trojúhelník)
    plot(S(2), S(1), 'o', 'MarkerSize',8, 'MarkerFaceColor','b', 'MarkerEdgeColor','b');
    plot(T(2), T(1), '^', 'MarkerSize',9, 'MarkerFaceColor','b', 'MarkerEdgeColor','b');

    title('Bludiště 5\times5 – zdi (K) vs. volno (W); S/T vyznačeny');
    hold off;
end
