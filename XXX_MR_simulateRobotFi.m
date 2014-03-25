function out = XXX_MR_simulateRobotFi(matrices, gps)
    % matrices: tablica komórkowa zawierająca poszczególne macierze
    % transformacji członów
    len = length(gps(:,1));
    out = zeros(len, 4);
    
    for i = 1:1:len
        mat = eye(4);
        for k = 1:1:length(matrices)
            mat = mat*subs(matrices{k}, gps(i,k));
        end
        out(i, :) = mat*[0,0,0,1]';
    end
end