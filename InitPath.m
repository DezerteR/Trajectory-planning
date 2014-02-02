function path = InitPath(robot)
% tworzy pust� scie�k�, ustawia punkt pocz�tkowy w wej�ciowym po�o�eniu
% robota
    path = {};
    path{end+1}.point = simulaterobotFi(robot, robot.bindGP);
    path{end}.type = 'initial';
    path{end}.w = 0.6;
    path{end}.delay = 0;
    path{end}.spacing = 0.8;

end