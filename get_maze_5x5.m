function [isWall,S,T] = get_maze_5x5(wallProb, seed, showPlots)
%UNTITLED2 Summaof this function goes here
%   Detailed explanation goes here
n = 5;
S = [1,1]; %start
T = [n,n]; %konec

if ~isempty(seed) %SEED - nejake cislo, ktere predstavuje pocatecni hodnotu generatoru  
    rng(seed,'twister');
end
isWall = rand(n,n) < wallProb;
%uvolneni zacatku a konce
isWall(S(1),S(2)) = false;
isWall(T(1), T(2)) = false;

if showPlots
    
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

end

