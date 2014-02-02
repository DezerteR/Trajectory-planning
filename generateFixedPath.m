function out = generateFixedPath(robot, path, shapes)
% path: w postaci punkt�w, to co zwraca smoothPath
limit = 5;    
i = 0;
terminate = false;
% test wst�pny
response  = PathCollisons(robot, path, shapes);
if isempty(response)
    terminate = true;
end
indices = response(:,1);

fixedPath = fixPath(robot, path, response, shapes, indices);

while ~terminate && i<limit
    i = i+1;
    
    response  = PathCollisons(robot, fixedPath, shapes);
    if isempty(response)
        terminate = true;
    else
        indices = response(:,1);
        fixedPath = fixPath(robot, fixedPath, response, shapes, indices);
    end
end

    if terminate == false
        fprintf('Nie ua�o si� poprawi� wszystkich kolizji, konieczna jest r�czna poprawka');
    end
    out = Interpolate(fixedPath);
end