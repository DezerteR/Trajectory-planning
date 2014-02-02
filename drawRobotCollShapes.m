function  drawRobotCollShapes(robot, gp, str, gr)
%     rysuje kszta�ty kolizyjne robota
%     gp: pozycja w kt�rem ma byc narysowany
%     str, gr: ~~
    if nargin<3
       str = 'm';
       gr = 1;
    elseif nargin<4
       gr = 1;
    end
       point = [0 0 0 1];
         transform = eye(4);
         idx = 1;
        for i = 1:1:robot.parts % dla ka�dego cz�onu
            
            if w_dot(robot.part(i).module.zmie, [1 1 1 1]) == 1
                transform = transform*substitution(gp(idx), robot.part(i).module);
                idx = idx +1;
            else
                transform = transform*substitution(0, robot.part(i).module);
            end
            
            shape = rotShape(robot.shape{i}, transform, point, robot.shapeDelay{i}, robot.initialPosition);
            
            point = (transform * [0 0 0 1]' )';
            
            drawCollShape(shape, str,gr);
            
        end
 
    
end
