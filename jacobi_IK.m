function out = jacobi_IK(robot, current_gp, aim, error, limit)
% oblicznie wsp��dnych z��czowych metod� jakobianow�
% podajemy robota, punkt z kt�rego zaczynamy, wsp��dne z��czowe tego
% punktu, punkt docelowy, opcjonalnie ilo�c iteracji
    if nargin<4
        limit = 200;
        error = 0.05;
    elseif nargin<5
      limit = 200;
    end
    
%     err = [];
%     pts = [];
   qcnt = [];
     out{2} = -1;
    e = error*2;
    
    jacobi = w_jacobian(current_gp,  robot);
    jjp = jacobi*jacobi';
    jacobi = jacobi';
    
    enhancement = computeEnhancement(robot, robot.zmie);
    current_point = simulateRobotFi(robot, current_gp);
    bool = w_distance(current_point, aim) > 10; % wtedy konieczne staje si� liczenie
    % jakobianu raz jeszcze, bo geometria za bardzo si� zmienia
    
    e = w_distance(aim, current_point);
    i = 0;
        while e>error && i < limit
            
%             pts = [pts; current_point];
            
            if bool
                jacobi = w_jacobian(current_gp,  robot);
                jjp = jacobi*jacobi';
                jacobi = jacobi';
            end
            i = i+1;
            delta = (aim-current_point);
            F = [delta(1:3) 0 0 0]';
            
            a = w_dot(jjp*F, F);
            a = a/w_dot(jjp*F,jjp*F);
%             a = 0.005;
            q = a*jacobi*F;
            q = q.*enhancement'.*robot.jointWeight;
            
            qcnt = [qcnt; q'];
            current_gp = current_gp+q';

            for k = 1:1:length(robot.min)
                current_gp(k) = min(robot.max(k), max(current_gp(k), robot.min(k)));
            end
            
            current_point = simulateRobotFi(robot, current_gp);
            e = w_distance(aim, current_point);

%             err = [err, e];
        end
     
        if e < error
            out{2} = 0;
       end
        out{1} = current_gp;
        
%     figure(2)
%     hold on
%     plot(err,'k')
%     plot(qcnt)
%     figure(1)
%     drawPath3d(pts, 'k',1.5);
end

function out = computeEnhancement(robot, zmie)
% wyznacza wzmocnienie konieczne dla przesuwania cz�on�w pryzmatycznych, bo
% s� za badzo redukowane i zbyt wolno si� poruszaj�
    out = [];
    for i = 1:1:length(zmie(:,1))
        if w_dot(zmie(i,:), [0 1 1 0]) == 1
            out = [out, robot.tweak];
        elseif w_dot(zmie(i,:), [1 0 0 1]) == 1
            out = [out, 1];
        end
    end
end
	



