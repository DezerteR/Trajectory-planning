function out = MoveTo(robot, pointA, pointB, shapes, YZexpand, size)
    % funkcja wyznacza w miar� bezkolizyjna tras� pomi�dzy punktami
    % YZexpand okresla jak bardzo rozsze�y si� sze�cian przestrzeni w
    % algorytmie A*, size okre�la ilo�� w�z��w na osi
    
    % zwraca
    % 1 - po interpolacji krzyw�
    % 2- po aproksymacji BSplajnem
    % 3- w�z�y scierzki

    resp = jacobi_IK(robot, robot.bindGP, pointA, 0.01, 500);
    initGP = resp{1};
    
    nodes = AStarDeformed(robot, pointA, pointB, shapes, size, YZexpand, initGP);
    
    if ~isempty(nodes)
        out{1} = SplineInterpolation(nodes);
        out{2} = NURBS(nodes);
        out{3} = nodes;
    else
        out = [];
        fprintf('\nNie uda�o si� znale��  trasy\n');
    end
    
end