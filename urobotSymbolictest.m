syms q1 real;
syms d1 d2 real;
syms q2 real;
syms q3 real;
syms q4 real;
syms a1 a2 a3 a4 real

matr = simulateRobotFi(robot, [q1 q2 q3 q4])
% matr = simulateRobotFiMatrices(robot, [q1 q2 q3 q4]);
% matr{1};
% matr{2};
% matr{3};
% matr{4};
% 
% mA(z1,z2,z3,z4)

A1 = mA(0, d1, a1, sym(-pi/2));
A2 = mA(q2, 0, a2, sym(pi/2));
A3 = mA(q3, a3, a3, 0)*mA(0, 0, 0, sym(-pi/2));
A4 = mA(0, 0, 0, q4);
% clc

A1*A2*A3;
% A = A1*A2*A3*A4*[0 0 0 1]'
A = A1*A2*A3*[0 0 0 1]'
 p = A1*[0 0 0 1]';

 
 %%
 e = [1500 0 500 1];
T03 = A1*A2*A3
pa = T03 * [0 0 0 1]'
%%
y1 = e(1) - pa(1);
y2 = e(2) - pa(2);
y3 = e(3) - pa(3);

out = solve(y1, y2, y3, 'd1,q2,q3'); 
%% 1500 0 500
gp = [];
for z = pi*2:-0.01*pi:-pi*2
    a = 450 - 600*cos(pi/2 + z)*(1 - 81/(6*sin(z) - 4)^2)^(1/2) - 400*(1 - 81/(6*sin(z) - 4)^2)^(1/2);
    b =  acos(9/(6*sin(z) - 4)) - pi;
    c = z;
        if isreal(a) && isreal(b) && isreal(c)
            gp = [gp; a,b,c,0];
        end
end
%% 1500 0 500 x2
gp = [];
for z = pi*2:-0.01*pi:-pi*2
    a =  400*(1 - 81/(6*sin(z) - 4)^2)^(1/2) + 600*cos(pi/2 + z)*(1 - 81/(6*sin(z) - 4)^2)^(1/2) + 450;
    b =  pi - acos(9/(6*sin(z) - 4));
    c = z;
        if isreal(a) && isreal(b) && isreal(c)
            gp = [gp; a,b,c,0];
        end
end
%% 
% res = [450 0 4.1267 0];
res = simulateRobotFi(robot, gp);
%% 
for i = 1:1:length(gp)
%     if isequal(e, res(i,:))
        if w_distance(e, res(i,:))<0.001
            gp(i,:)
            drawRobot(robot, gp(i,:))
    end
end
%% 
point = [1552.5   0    5.4    1];
figure(1)
drawPoint3d(point);
for i=1:1:100
    qq = jacobi_IK(robot, robot.bindGP, path(i,:) - [100 0 0 0], 0.01, 600);
end
% if qq{2} ~= -1
    qq{1};
    simulateRobotFi(robot, qq{1})
    
figure(1)
    drawRobot(robot, qq{1});
% end
    