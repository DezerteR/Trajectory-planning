function out = AStarDeformed(robot, a, b, shapes, len, deform,initialGP)
% wariacja A* dla 3D
% wariacja wariacji, przedzia� wyd�u�ony jest wzd�� osi x, lub wszerz
% zwraca w�z�y dla krzywej interpoluj�cej
    out = [];
    terminate = false;
    found = false;
    if nargin == 5
        len = 5 ;
        initialGP = robot.bindGP;   
        deform = 1;
    elseif nargin == 6
        initialGP = robot.bindGP;   
    end
    vec = w_normalize(b - a);
    dista = w_distance(a,b);
    
    %% gp dla punktu a, z tego punktu wyliczamy wszystkie w�z�y
    response = jacobi_IK(robot, initialGP, a, 0.1, 250);
    if response{2} == 0
        GP = response{1};
    else
        GP = initialGP;
    end
    
    
    step = dista/(len-2); % mm

%     drawPoint3d(a,'ro',2);
    hold on  
    
    axes = computeAxes(vec);% osie, u�ozone tak �e x jest r�wnoleg�y do vec
    x = axes(1,:);
    y = axes(2,:)*deform;
    z = axes(3,:)*deform;
    
    axes = [x;y;z];
% Debug, osie uk�adu
%     drawLine3d(a, a+x*50, 'r',2);
%     drawLine3d(a, a+y*50, 'g',2);
%     drawLine3d(a, a+z*50, 'b',2);

    
    tab = zeros(len, len, len);
    tab(:,:,:) = -1;
    
    hl = ceil(len/2);
    pos = [2 hl hl 0];
    posIn = a;
    p000 = a - (2*x + y*hl + z*hl)*step;
    drawPoint3d(a, 'ko',1);
    drawPoint3d(b, 'ko',1);
    drawPoint3d(a, 'k.',2);
    drawPoint3d(b, 'k.',2);
    aim = [len ceil(len/2) ceil(len/2) 0];
    
    tab(pos(1), pos(2), pos(3)) = 0;
    que = [];
    que(end+1, :) = pos;
    it = 1;
    
    cur = a;
    %% kierunki ruchu
    vecs = [
        -1 0 0 0;
        0 -1 0 0;
        0 0 -1 0;
        
        -1 -1 0 0;
        -1 0 -1 0;
        0 -1 -1 0;
        
        1 1 0 0;
        1 0 1 0;
        0 1 1 0;
        
        1 -1 0 0;
        1 0 -1 0;
        0 1 -1 0;
        
        -1 1 0 0;
        -1 0 1 0;
        0 -1 1 0;
        
        1 0 0 0;
        0 1 0 0;
        0 0 1 0;
    ];
    reverseStr = '';
    %%
    g = 0;
    while ~terminate && ~isempty(que)
        % wypisuje w konsoli ile w�zl�w ju� przetworzono, pokazuje �e funkcja dziala
        g = g+1;
        msg = sprintf('Processed %d', g);
        fprintf([reverseStr, msg]);
        reverseStr = repmat(sprintf('\b'), 1, length(msg));
        
        % zdejmujemy ostatni element
        pos = que(end,:);
        que(end,:) = [];

        cval = tab(pos(1), pos(2), pos(3));
        
        
        % sprawdzamy okoliczne punkty, czy nie s� czasem osi�galne, je�li
        % s� to uk�adamy na nich przebyta drog�
        for i = randperm(18)
%         for i =1:1:18
            tpos = pos + vecs(i,:);
%                 drawPoint3d(comp(tpos, step, p000, axes), 'ko',5);
            
            % czy mie�ci si� w zakresie
            if isInRange(tpos, len)
                
                tabval = tab(tpos(1), tpos(2), tpos(3));
                
            %czy jest polem docelowym
  
                
                % czy by� ju� analizowany
                if tabval == -1
                    
                    test = testNode(robot, comp(tpos, step, p000, axes), shapes, GP);
                    if test
                        tab(tpos(1), tpos(2), tpos(3)) = cval+1;
                        que(end+1,:) = tpos;
%                         drawPoint3d(comp(tpos, step, p000, axes), 'k.');
                    else
%                         point34 = comp(tpos, step, p000, axes);
%                         if abs(point34(2)) < 1
%                             drawPoint3d(point34, 'r.');
%                         end
                        tab(tpos(1), tpos(2), tpos(3)) = -2;
                    end
                elseif tabval ~= -2 && tabval > cval+1
                    tab(tpos(1), tpos(2), tpos(3)) = cval+1;
%                     if tabval > cval+1
                        que(end+1,:) = tpos;    
%                     end
                end
                
                  if isequal(tpos, aim)  
                        found = true;
                        tabval = tab(tpos(1), tpos(2), tpos(3));
                        % je�li dotarto do punktu ko�cowego i rozwi�zanie
                        % jest wystarczaj�co kr�tki, mo�na skr�ci�
%                         if tabval < len 
%                             terminate = true;
%                         end
                end
                
            end
        end
    end
    
    if found
        fprintf('\nZnaleziono rozwi�zanie\n');
        out = resolvePath(tab, aim, len,  p000, axes, step);
    end
    
end

function out = isInRange(pos, len)
% sprawdza czy punkt nie wychodzi poza tablic�
    out = true;
    for i = 1:1:3
        if pos(i)<1 || pos(i)>len
            out = false;
            break
        end
    end
end

function out = comp(pos, step, pos0real, axes)
% zamienia wsp�z�dne tablicowe na przetrzenne
    x = axes(1,:);
    y = axes(2,:);
    z = axes(3,:);
    out = pos0real + (x*pos(1) + y*pos(2) + z*pos(3))*step;
end

function out = computeAxes(vec)
%     rzutujemy na p�aszczyzn� XY
    planeXY = [0 0 1 0];
    dist = w_dot(planeXY, vec);
    
    xp = w_normalize(vec - [0 0 -1 0]*dist);
    yp = [w_normalize(w_cross([0 0 1 0], xp)) 0];
    
    zp = [w_normalize(w_cross(vec, yp)) 0];
    
    out = [vec; yp;zp];
end

function out = resolvePath(tab, last, len, p0, axes, step)
    % idziemy od ko�ca, wyszukujemy  punkty o jak najmniejszej warto�ci
    %%
    vecs = [
        -1 0 0 0;
        0 -1 0 0;
        0 0 -1 0;
        
        -1 -1 0 0;
        -1 0 -1 0;
        0 -1 -1 0;
        
        1 1 0 0;
        1 0 1 0;
        0 1 1 0;
        
        1 -1 0 0;
        1 0 -1 0;
        0 1 -1 0;
        
        -1 1 0 0;
        -1 0 1 0;
        0 -1 1 0;
        
        1 0 0 0;
        0 1 0 0;
        0 0 1 0;
    ];
    out = [];
    %%
    pos = last;
    out = [out; comp(pos, step, p0, axes)];
    
    cval = tab(pos(1), pos(2), pos(3));
    mincval = 500000;
    id = 1;
    while cval ~= 0
    for i =1:1:18
        tpos = pos + vecs(i,:);
        
        if isInRange(tpos, len)
            tabval = tab(tpos(1), tpos(2), tpos(3));
            
            % znajdujemy najmniejsz� warto�� w�r�d okolicznych p�l
            if tabval < mincval && tabval>=0
                mincval = tabval;
                id = i;
            end
        end
        
    end
    pos = pos + vecs(id,:);
    cval = mincval;
    out = [out; comp(pos, step, p0, axes)];
    end
    out = out(end:-1:1,:);
end

