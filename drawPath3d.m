function hold = drawPath3d(path, str, gr)
    %rysuje trajektor� w 3d, na podstawie kolejnych punkt�w(vectory 4elementowe),
    if nargin<2
       str='b';
       gr=0.5;
    elseif nargin<3
        gr=0.5;
    end
    
    hold = plot3(path(:,1), path(:,2), path(:,3), str,'LineWidth',gr);
end