function out = findPathErrors(robot, path, shapes)
    % zwraca tablic� kom�rkow�, w ka�dej kom�rce znajduj� si� indeksy
    % punkt�w dla kt�rych co� nie gra, obojetnie co, i tak trzeba to obej��

    %%
    out = [];
    veryBadIndices = findBadIndices(robot, path, shapes);
    len = length(veryBadIndices);
%     drawPath3d(path(veryBadIndices,:), 'r.')
%     hold on
%     drawPath3d(path, 'k')
    %%
    veryBadIndices = unique(veryBadIndices);
    if len > 0
        out = partitionBadIndices(veryBadIndices);
    end
end

function out = findBadIndices(robot, path, shapes)
    out = [];
    %% kolizje punkt�w trasy z otoczeniem
    response  = PathCollisons(robot, path, shapes);
    collisionIndices = [];
    if ~isempty(response)
        collisionIndices = response(:,1);
%         drawPath3d(path(collisionIndices,:), 'r.');
    end
    %% IK z ma�aprecyzj�
    delay = 2;
    response  = computeGP(robot, path, delay, 0.1, 100, true);
    %%
    indices = response{2};
%     drawPath3d(path(indices,:), 'y.');
    unreachableIndices = [];
    tab = -ceil(delay/2) : 1:floor(delay/2)-1;
    for i =1:1:length(indices)
        unreachableIndices = [unreachableIndices, tab+indices(i);];
    end
    gps = response{1};
    %%
    unreachableIndices = unreachableIndices(unreachableIndices(:)> 0);
    unreachableIndices = unreachableIndices(unreachableIndices(:)<= length(path));
    %% kolizje co 'delay' punktu z przeszkodami
    response = collisionTest(robot, gps, shapes, true);
    indices = [];
    if ~isempty(response)
        indices = response(:,1);
%     drawPath3d(path(indices,:), 'g.');
    end
    indices = indices.*delay;
    
    %%
    unreachableIndices2 = [];
    tab = -ceil(delay/2) : 1:floor(delay/2)-1;
    for i =1:1:length(indices)
        unreachableIndices2 = [unreachableIndices2, tab+indices(i);];
    end
    unreachableIndices2 = unreachableIndices2(unreachableIndices2(:)> 0);
    unreachableIndices2 = unreachableIndices2(unreachableIndices2(:)<= length(path));
    %% suma zbior�w
    tmp = union(collisionIndices, unreachableIndices);
    out = union(tmp, unreachableIndices2);
end

function out = partitionBadIndices(badIndices)
% zwraca tablic� kom�rkow� zawieraj�c� przedzia�y z�ych indeks�w
    out = {};
    tmp =[];

    % wykry� i oddzieli� 
    tmp = [badIndices(1)];
    for i = 2:1:length(badIndices)
        if abs(badIndices(i) - badIndices(i-1)) > 15
            out{end+1} = tmp;
            tmp = [badIndices(i)];
        end
        tmp = [tmp; badIndices(i)];
    end
    out{end+1} = unique(tmp);
    
end

