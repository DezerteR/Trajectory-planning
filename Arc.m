function path = Arc(path, pointA, pointB, w, delay)
    % wykonuje  �uk pomi�dzy ostatnim punktem ze scie�ki poprzez punkt
    % pierwsz, ko�czy w punkcie ostatnim
    % by� podany jest to aktualan a pozycja robota
    
    if nargin  <4
        w = 0.7;
        delay = 80;
    elseif nargin <5
        delay = 80;
    end
    
    
    
    path{end+1}.point = [pointA; pointB];
    path{end}.type = 'arc';
    path{end}.w = w;
    path{end}.delay = delay;
    
end
