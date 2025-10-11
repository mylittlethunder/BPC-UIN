function visualize_maze_graph(isWall, S, T)
% VISUALIZE_MAZE_GRAPH  Graf volných buněk (4-okolí) s číslovanými uzly.
% Uzly = volná pole (~isWall). Hrany = sousedé vpravo/dolů (bez duplikace).
% S a T jsou zvýrazněny. (1,1) vlevo nahoře.

    if nargin < 2 || isempty(S), S = [1,1]; end
    if nargin < 3 || isempty(T), T = [size(isWall,1), size(isWall,2)]; end

    n = size(isWall,1);

    % Uzly (volná pole) v pořadí r=1..n, c=1..n
    freeLin = find(~isWall);
    numNodes = numel(freeLin);
    if numNodes == 0
        figure('Name','Graf 4-okolí'); title('Žádné volné uzly'); return;
    end

    nodeIdOfLin = zeros(n*n,1);           % map: lineární index -> ID (1..numNodes)
    nodeIdOfLin(freeLin) = 1:numNodes;

    [nodeR, nodeC] = ind2sub([n n], freeLin);
    nodeCoordsRC = [nodeR(:), nodeC(:)];

    % Hrany (jen doprava/dolů)
    edges = [];
    for i = 1:numNodes
        r = nodeCoordsRC(i,1);
        c = nodeCoordsRC(i,2);
        % vpravo
        if c+1<=n && ~isWall(r,c+1)
            u = i; v = nodeIdOfLin(sub2ind([n n], r, c+1));
            edges(end+1,:) = [u, v]; %#ok<AGROW>
        end
        % dolů
        if r+1<=n && ~isWall(r+1,c)
            u = i; v = nodeIdOfLin(sub2ind([n n], r+1, c));
            edges(end+1,:) = [u, v]; %#ok<AGROW>
        end
    end

    % Vykreslení grafu
    X = nodeCoordsRC(:,2); Y = nodeCoordsRC(:,1);
    if isempty(edges)
        G = graph;  % izolované uzly
        figure('Name','Graf 4-okolí (volná pole)');
        pg = plot(G,'XData',X,'YData',Y,'MarkerSize',6,'LineWidth',2);
    else
        G = graph(edges(:,1), edges(:,2), [], numNodes);
        figure('Name','Graf 4-okolí (volná pole)');
        pg = plot(G,'XData',X,'YData',Y,'MarkerSize',6,'LineWidth',2);
    end
    axis equal;
    set(gca,'YDir','reverse','XTick',1:n,'YTick',1:n);
    grid on; hold on;

    % Číslování uzlů
    pg.NodeLabel = string(1:numnodes(G));

    % Zvýraznění S a T (pokud existují jako volné uzly)
    sId = nodeIdOfLin(sub2ind([n n], S(1), S(2)));
    tId = nodeIdOfLin(sub2ind([n n], T(1), T(2)));
    if sId > 0, highlight(pg, sId, 'NodeColor','b', 'MarkerSize',8); end
    if tId > 0, highlight(pg, tId, 'NodeColor','b', 'MarkerSize',9); end

    title('Graf volných buněk (4-okolí) s číslovanými uzly; S/T zvýrazněny');
    hold off;
end
