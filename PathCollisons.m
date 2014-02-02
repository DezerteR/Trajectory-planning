function out = PathCollisons(robot, path, collShapes)
    % wyszukuje w kt�rym miejscu scierzka przecina przedmioty
    % zwraca indeksy punkt�w w kt�rych nast�pi�o przeci�cie
    out = [];
    if isempty(path)
        return
    end
    len = length(path(:,1));
    for i = 1:1:len
        sphere = Sphere(path(i, :), robot.efector_radius);
        tmp = test(sphere, collShapes);
        if tmp ~= 0
            out = [out; i tmp];
        end
    end
    
    
end

function out = test(sphere, collShapes)
    % sprawdza kolizj� punktu, sfery z przeszkodami
    out = 0;
    for i = 1:1:length(collShapes)
        it = collShapes{i};
        if w_distance(sphere.center, it.center) <= sphere.sph_r + it.sph_r
            if Collision(sphere, it)
                out = i;
                break;
            end
        end
    end
end