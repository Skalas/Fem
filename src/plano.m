function z=plano(x,x0,x1,x2)
a=x1-x2;
b=x0-x2;
eta=[a(2).*b(3)-a(3).*b(2)...
     a(3).*b(1)-a(1).*b(3)...
     a(1).*b(2)-a(2).*b(1)];
z=-((x(1)-x0(1))*eta(1)+ (x(2)-x0(2))*eta(2))/eta(3) + x0(3);
