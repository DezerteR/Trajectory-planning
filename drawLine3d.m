function hold = drawLine3d(a,b, str, gr)
% Description
% .........................................................................
% Autor:                    Karol Wajs
% Date updating:            23.01.2014 r
%
% .........................................................................
% 
% 
% 
% 
%
% Input data:
% a,b - points
% 
% 
% 
% 
% 
% Output data:
% uchwyt do narysowanego obiektu
% 
% .........................................................................

%%

    if nargin<3
       str='b';
       gr=0.5;
    elseif nargin<4
        gr=0.5;
    end
    hold = plot3([a(1) b(1)], [a(2) b(2)], [a(3) b(3)], str,'LineWidth',gr);
end