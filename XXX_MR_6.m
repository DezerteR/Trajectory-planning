syms vz1 vz2 vz3 vz4 real;
vz = [vz1 vz2 vz3 vz4];

syms az1 az2 az3 az4 real;
az = [az1 az2 az3 az4];

gg =[0 0 -9.81 0];

%%
F = fun_F(J, ms, vz,az,gg,model,zmie,p)
% F = [ 981/100*m1 + 981/100*m2 + 981/100*m3 + 981/100*m4 -
% vz3^2*(m4*sin(q2)*sin(q3) - a3*m4*cos(q3)*sin(q2)) - az2*(m3*(a2*cos(q2)
% + a3*cos(q2)*cos(q3)) + 1/2*a3*m3*cos(q2)*cos(q3)) + az1*m1 + az1*m2 + az1*m3 + az1*m4 + vz2^2*(m4*(a2*sin(q2) + a3*cos(q3)*sin(q2)) - m4*sin(q2)*sin(q3)) + az3*(m4*cos(q3)*sin(q2) + a3*m4*sin(q2)*sin(q3)) + vz2^2*(m3*(a2*sin(q2) + a3*cos(q3)*sin(q2)) + 1/2*a3*m3*cos(q3)*sin(q2)) - az2*(m4*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - m4*cos(q2)*sin(q3)) + 2*vz2*vz3*(m4*cos(q2)*cos(q3) + a3*m4*cos(q2)*sin(q3)) - 3/2*a2*az2*m2*cos(q2) + 3/2*a2*m2*vz2^2*sin(q2) + 3/2*a3*az3*m3*sin(q2)*sin(q3) + 3/2*a3*m3*vz3^2*cos(q3)*sin(q2) + 3*a3*m3*vz2*vz3*cos(q2)*sin(q3), vz2^2*((m4*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - m4*cos(q2)*sin(q3))*(a2*sin(q2) + a3*cos(q3)*sin(q2)) - (m4*(a2*sin(q2) + a3*cos(q3)*sin(q2)) - m4*sin(q2)*sin(q3))*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - sin(q2)*sin(q3)*(m4*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - 4/3*m4*cos(q2)*sin(q3)) + cos(q2)*sin(q3)*(m4*(a2*sin(q2) + a3*cos(q3)*sin(q2)) - 4/3*m4*sin(q2)*sin(q3))) - az1*(m3*(a2*cos(q2) + a3*cos(q2)*cos(q3)) + 1/2*a3*m3*cos(q2)*cos(q3)) - 981/100*m3*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - 981/100*m4*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - az3*((a2*cos(q2) + a3*cos(q2)*cos(q3))*(m4*cos(q3)*sin(q2) + a3*m4*sin(q2)*sin(q3)) - (a2*sin(q2) + a3*cos(q3)*sin(q2))*(m4*cos(q2)*cos(q3) + a3*m4*cos(q2)*sin(q3)) + sin(q2)*sin(q3)*(4/3*m4*cos(q2)*cos(q3) + a3*m4*cos(q2)*sin(q3)) - cos(q2)*sin(q3)*(4/3*m4*cos(q3)*sin(q2) + a3*m4*sin(q2)*sin(q3))) - vz3^2*(3/2*a3*m3*cos(q3)*sin(q2)*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - 3/2*a3*m3*cos(q2)*cos(q3)*(a2*sin(q2) + a3*cos(q3)*sin(q2))) + az2*((a2*cos(q2) + a3*cos(q2)*cos(q3))*(m3*(a2*cos(q2) + a3*cos(q2)*cos(q3)) + 1/2*a3*m3*cos(q2)*cos(q3)) + (a2*sin(q2) + a3*cos(q3)*sin(q2))*(m3*(a2*sin(q2) + a3*cos(q3)*sin(q2)) + 1/2*a3*m3*cos(q3)*sin(q2)) + cos(q2)*cos(q3)*(1/2*a3*m3*(a2*cos(q2) + a3*cos(q2)*cos(q3)) + 1/4*a3^2*m3*cos(q2)*cos(q3)) + cos(q3)*sin(q2)*(1/2*a3*m3*(a2*sin(q2) + a3*cos(q3)*sin(q2)) + 1/4*a3^2*m3*cos(q3)*sin(q2))) + az2*((m4*(a2*sin(q2) + a3*cos(q3)*sin(q2)) - m4*sin(q2)*sin(q3))*(a2*sin(q2) + a3*cos(q3)*sin(q2)) + (m4*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - m4*cos(q2)*sin(q3))*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - cos(q2)*sin(q3)*(m4*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - 4/3*m4*cos(q2)*sin(q3)) - sin(q2)*sin(q3)*(m4*(a2*sin(q2) + a3*cos(q3)*sin(q2)) - 4/3*m4*sin(q2)*sin(q3))) + vz3^2*((a2*cos(q2) + a3*cos(q2)*cos(q3))*(m4*sin(q2)*sin(q3) - a3*m4*cos(q3)*sin(q2)) - (a2*sin(q2) + a3*cos(q3)*sin(q2))*(m4*cos(q2)*sin(q3) - a3*m4*cos(q2)*cos(q3)) + sin(q2)*sin(q3)*(4/3*m4*cos(q2)*sin(q3) - a3*m4*cos(q2)*cos(q3)) - cos(q2)*sin(q3)*(4/3*m4*sin(q2)*sin(q3) - a3*m4*cos(q3)*sin(q2))) + az2*(9/4*m2*a2^2*cos(q2)^2 + 9/4*m2*a2^2*sin(q2)^2) + vz2^2*((m3*(a2*cos(q2) + a3*cos(q2)*cos(q3)) + 1/2*a3*m3*cos(q2)*cos(q3))*(a2*sin(q2) + a3*cos(q3)*sin(q2)) - (a2*cos(q2) + a3*cos(q2)*cos(q3))*(m3*(a2*sin(q2) + a3*cos(q3)*sin(q2)) + 1/2*a3*m3*cos(q3)*sin(q2)) + cos(q3)*sin(q2)*(1/2*a3*m3*(a2*cos(q2) + a3*cos(q2)*cos(q3)) + 1/4*a3^2*m3*cos(q2)*cos(q3)) - cos(q2)*cos(q3)*(1/2*a3*m3*(a2*sin(q2) + a3*cos(q3)*sin(q2)) + 1/4*a3^2*m3*cos(q3)*sin(q2))) - az1*(m4*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - m4*cos(q2)*sin(q3)) - az3*(3/2*a3*m3*sin(q2)*sin(q3)*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - 3/2*a3*m3*cos(q2)*sin(q3)*(a2*sin(q2) + a3*cos(q3)*sin(q2))) - 2943/200*a2*m2*cos(q2) - 2*vz2*vz3*(3/2*a3*m3*cos(q2)*sin(q3)*(a2*cos(q2) + a3*cos(q2)*cos(q3)) + 3/2*a3*m3*sin(q2)*sin(q3)*(a2*sin(q2) + a3*cos(q3)*sin(q2)) + 3/4*a3^2*m3*cos(q2)^2*cos(q3)*sin(q3) + 3/4*a3^2*m3*cos(q3)*sin(q2)^2*sin(q3)) + 981/100*m4*cos(q2)*sin(q3) - 2*vz2*vz3*((a2*cos(q2) + a3*cos(q2)*cos(q3))*(m4*cos(q2)*cos(q3) + a3*m4*cos(q2)*sin(q3)) + (a2*sin(q2) + a3*cos(q3)*sin(q2))*(m4*cos(q3)*sin(q2) + a3*m4*sin(q2)*sin(q3)) - sin(q2)*sin(q3)*(4/3*m4*cos(q3)*sin(q2) + a3*m4*sin(q2)*sin(q3)) - cos(q2)*sin(q3)*(4/3*m4*cos(q2)*cos(q3) + a3*m4*cos(q2)*sin(q3))) - 3/2*a2*az1*m2*cos(q2) - 981/200*a3*m3*cos(q2)*cos(q3), vz2^2*(cos(q2)*sin(q3)*(1/2*a3*m3*(a2*cos(q2) + a3*cos(q2)*cos(q3)) + 1/4*a3^2*m3*cos(q2)*cos(q3)) + sin(q2)*sin(q3)*(1/2*a3*m3*(a2*sin(q2) + a3*cos(q3)*sin(q2)) + 1/4*a3^2*m3*cos(q3)*sin(q2)) + a3*sin(q2)*sin(q3)*(m3*(a2*sin(q2) + a3*cos(q3)*sin(q2)) + 1/2*a3*m3*cos(q3)*sin(q2)) + a3*cos(q2)*sin(q3)*(m3*(a2*cos(q2) + a3*cos(q2)*cos(q3)) + 1/2*a3*m3*cos(q2)*cos(q3))) + vz2^2*(cos(q2)*cos(q3)*(m4*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - 4/3*m4*cos(q2)*sin(q3)) + cos(q3)*sin(q2)*(m4*(a2*sin(q2) + a3*cos(q3)*sin(q2)) - 4/3*m4*sin(q2)*sin(q3)) + a3*cos(q2)*sin(q3)*(m4*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - m4*cos(q2)*sin(q3)) + a3*sin(q2)*sin(q3)*(m4*(a2*sin(q2) + a3*cos(q3)*sin(q2)) - m4*sin(q2)*sin(q3))) + az3*(sin(q3)*(4/3*m4*sin(q3) - a3*m4*cos(q3)) - a3*cos(q3)*(m4*sin(q3) - a3*m4*cos(q3)) + cos(q2)*cos(q3)*(4/3*m4*cos(q2)*cos(q3) + a3*m4*cos(q2)*sin(q3)) + cos(q3)*sin(q2)*(4/3*m4*cos(q3)*sin(q2) + a3*m4*sin(q2)*sin(q3)) + a3*cos(q2)*sin(q3)*(m4*cos(q2)*cos(q3) + a3*m4*cos(q2)*sin(q3)) + a3*sin(q2)*sin(q3)*(m4*cos(q3)*sin(q2) + a3*m4*sin(q2)*sin(q3))) + az1*(m4*cos(q3)*sin(q2) + a3*m4*sin(q2)*sin(q3)) - az2*(sin(q2)*sin(q3)*(1/2*a3*m3*(a2*cos(q2) + a3*cos(q2)*cos(q3)) + 1/4*a3^2*m3*cos(q2)*cos(q3)) - cos(q2)*sin(q3)*(1/2*a3*m3*(a2*sin(q2) + a3*cos(q3)*sin(q2)) + 1/4*a3^2*m3*cos(q3)*sin(q2)) - a3*cos(q2)*sin(q3)*(m3*(a2*sin(q2) + a3*cos(q3)*sin(q2)) + 1/2*a3*m3*cos(q3)*sin(q2)) + a3*sin(q2)*sin(q3)*(m3*(a2*cos(q2) + a3*cos(q2)*cos(q3)) + 1/2*a3*m3*cos(q2)*cos(q3))) + vz3^2*(9/4*m3*cos(q3)*sin(q3)*a3^2*cos(q2)^2 + 9/4*m3*cos(q3)*sin(q3)*a3^2*sin(q2)^2 - 9/4*m3*cos(q3)*sin(q3)*a3^2) - az2*(cos(q3)*sin(q2)*(m4*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - 4/3*m4*cos(q2)*sin(q3)) - cos(q2)*cos(q3)*(m4*(a2*sin(q2) + a3*cos(q3)*sin(q2)) - 4/3*m4*sin(q2)*sin(q3)) + a3*sin(q2)*sin(q3)*(m4*(a2*cos(q2) + a3*cos(q2)*cos(q3)) - m4*cos(q2)*sin(q3)) - a3*cos(q2)*sin(q3)*(m4*(a2*sin(q2) + a3*cos(q3)*sin(q2)) - m4*sin(q2)*sin(q3))) - vz3^2*(a3*cos(q3)*(m4*cos(q3) + a3*m4*sin(q3)) - sin(q3)*(4/3*m4*cos(q3) + a3*m4*sin(q3)) + cos(q2)*cos(q3)*(4/3*m4*cos(q2)*sin(q3) - a3*m4*cos(q2)*cos(q3)) + cos(q3)*sin(q2)*(4/3*m4*sin(q2)*sin(q3) - a3*m4*cos(q3)*sin(q2)) + a3*cos(q2)*sin(q3)*(m4*cos(q2)*sin(q3) - a3*m4*cos(q2)*cos(q3)) + a3*sin(q2)*sin(q3)*(m4*sin(q2)*sin(q3) - a3*m4*cos(q3)*sin(q2))) + az3*(9/4*m3*a3^2*cos(q2)^2*sin(q3)^2 + 9/4*m3*a3^2*cos(q3)^2 + 9/4*m3*a3^2*sin(q2)^2*sin(q3)^2) + 2*vz2*vz3*(cos(q3)*sin(q2)*(4/3*m4*cos(q2)*cos(q3) + a3*m4*cos(q2)*sin(q3)) - cos(q2)*cos(q3)*(4/3*m4*cos(q3)*sin(q2) + a3*m4*sin(q2)*sin(q3)) + a3*sin(q2)*sin(q3)*(m4*cos(q2)*cos(q3) + a3*m4*cos(q2)*sin(q3)) - a3*cos(q2)*sin(q3)*(m4*cos(q3)*sin(q2) + a3*m4*sin(q2)*sin(q3))) + 981/100*m4*cos(q3)*sin(q2) + 2943/200*a3*m3*sin(q2)*sin(q3) + 981/100*a3*m4*sin(q2)*sin(q3) + 3/2*a3*az1*m3*sin(q2)*sin(q3), 0];
%%
i=1;
FSS1 = subs(F(1), {'m1','m2','m3','m4',a1,a2,a3},{m(1),m(2),m(3),m(4),c1,c2,c3});
FS1=double(subs(FSS1,{d1,q2,q3,q4,vz1,vz2,vz3,vz4,az1,az2,az3,az4},{
   xt1,xt2,xt3,xt4,vt1,vt2,vt3,vt4,at1,at2,at3,at4}));

FSS2 = subs(F(2), {'m1','m2','m3','m4',a1,a2,a3},{m(1),m(2),m(3),m(4),c1,c2,c3});
FS2=double(subs(FSS2,{d1,q2,q3,q4,vz1,vz2,vz3,vz4,az1,az2,az3,az4},{
   xt1,xt2,xt3,xt4,vt1,vt2,vt3,vt4,at1,at2,at3,at4}));

FSS3 = subs(F(3), {'m1','m2','m3','m4',a1,a2,a3},{m(1),m(2),m(3),m(4),c1,c2,c3});
FS3=double(subs(FSS3,{d1,q2,q3,q4,vz1,vz2,vz3,vz4,az1,az2,az3,az4},{
   xt1,xt2,xt3,xt4,vt1,vt2,vt3,vt4,at1,at2,at3,at4}));

FSS4 = subs(F(4), {'m1','m2','m3','m4',a1,a2,a3},{m(1),m(2),m(3),m(4),c1,c2,c3});
FS4=double(subs(FSS4,{d1,q2,q3,q4,vz1,vz2,vz3,vz4,az1,az2,az3,az4},{
   xt1,xt2,xt3,xt4,vt1,vt2,vt3,vt4,at1,at2,at3,at4}));

%%
figure(1)
plot(tt1,FS1,'k')
title('czlon 1, pryzmatyczny');
xlabel('[s]')
ylabel('[N]')
figure(2)
hold on
plot(tt1,FS2,'r')
plot(tt1,FS3,'g')
plot(tt1,FS4,'b')
xlabel('[s]')
ylabel('[N/m]')
title('cz�ony obrotowe');
legend('2','3','4');

%%
Power{1} = FS1.*vt1;
Power{2} = FS2.*vt2;
Power{3} = FS3.*vt3;
Power{4} = FS4.*vt4;
%%
figure(1)
plot(tt1,Power{1} ,'k')
title('czlon 1, pryzmatyczny');
xlabel('[s]')
ylabel('[W]')

figure(2)
hold on
plot(tt1,Power{2} ,'r')
plot(tt1,Power{3},'g')
plot(tt1,Power{4} ,'b')
xlabel('[s]')
ylabel('[W]')
title('cz�ony obrotowe');
legend('2','3','4');