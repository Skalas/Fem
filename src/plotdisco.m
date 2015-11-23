t=linspace(0,1,1000);
hold on
x1=0.5*cos(2*pi*t);
y1=0.5*sin(2*pi*t);
plot(x1,y1)
x=cos(2*pi*t);
y=sin(2*pi*t);
plot(x,y)
axis([-1.2,1.1,-1.1,1.1])