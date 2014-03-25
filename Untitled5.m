% resolwing collisions
kol = [];
points = input3D(2);
%%
 for i = 1:1:length(points)
     hold on
     drawPoint3d(points(i,:), 'ko');
 end
 %%
hold on
points = [];
p1 = [25 69 0 1];
    points = [points; p1];

p1 = p1+[25 25 0 0];
    points = [points; p1];
p1 = p1+[25 25 0 0];
    points = [points; p1];
p1 = p1+[25 25 0 0];
    points = [points; p1];
p1 = p1+[25 25 0 0];
%     points = [points; p1];
%%
drawPath3d(NURBS(points), 'k');
drawPath3d(points, 'ko');

%% spline interpolation
path = SplineInterpolation(points);
drawPath3d(path, 'k');
%%
shapes = {};
result = generateFixedPath(robot, interped, shapes);
%%
drawPath3d(result,'k',1);
hold on
% drawPath3d(interped);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% resolve robot collisons
% compute gps
    gpIndicesSpacing = 10; % sprawdamy co 10� konfiguracj�, leniwy jestem
    resp = computeGP(robot, result, gpIndicesSpacing, 0.01, 200);
     gps = resp{1}; % wsp��dne punkt�w osi�gni�tych
    bad_indices = resp{2}; % punkty nieosi�galne
% najpierw nale�y poprawi� punkty tak by by�y osi�galne
    %%
    hold on
    drawPath3d(result(firstGoodInd:lastGoodInd,:),' k',0.5);
    
    %% wykrycie stref nieosiagalnych
    % obci�cie stref poczatkowych i ko�cowych, te nigdy nie bed� osi�galne
    firstGoodInd = 1;
    lastGoodInd = length(result);
    if bad_indices(1) == 1
        for i = 2:1:length(bad_indices)
            if bad_indices(i) ~= firstGoodInd+1
                break;
            end
            firstGoodInd = bad_indices(i);
        end
    end
    
    if bad_indices(end) == length(result);
        for i = length(bad_indices)-1 : -1 : 1
            if bad_indices(i) ~= lastGoodInd-gpIndicesSpacing
                break;
            end
            lastGoodInd = bad_indices(i);
        end
    end
    %% partitioning
    parts = {};
    tmp =[];
    indices = bad_indices;
    % wykry� i oddzieli� 
    for i = 2:1:length(indices)
        if indices(i) ~= indices(i-1) +1
            parts{end+1} = tmp;
            tmp = [];
        end
        tmp = [tmp; response(i,:)];
    end
    parts{end+1} = tmp;
    %% resolwing path for each part
    % wyznaczane s� punkty, w pewnej odleg�o�ci od punkt�w ostatnich, lub
    % te ostanie
    % wyznaczana jest prosta i plaszczyzna na kt�rej prosta le�y, pomi�dzy
    % tymi punktami
    % 
    % na p�aszczy�nie wybierane s� punkty lez�ce po oby stronach prosstej
    % nastepnie wyszukiwana jest optymalna trasa przechodz�ca przez punkty
    % le��ce w przestrani roboczej, NIE DZIA�A DLA ORIENTACJI, TA MUSI BY�
    % JU� PRZEMY�LANA
    % punkty wybieramy po drugiej stronie prostej ni� punkty poprawne, lub
    % po losowej
    
    