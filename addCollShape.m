function robot = addCollShape(robot, shape, delay)
	% dodaje do struktury robota nowy kszta�t otaczaj�cy cz�on
    if nargin < 3
        delay = [0 0 0 0];
    end
    robot.shapeDelay{end+1} = delay;
    robot.shape{end+1} = shape;
end