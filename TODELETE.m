% bezier opisujacy charakterystyk� regulacji silnika? 
bezier = [
 0 1;
 0.5 1;
 1 1;
 1 1;
 ];

t = 0:0.01:1;
resp = bezierN(bezier, t);
plot(t, resp(:,1))
hold on
plot(-t, -resp(:,1))
grid
hold off
