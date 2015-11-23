%%script para hacer el meshgrid con para la prueba

f='fname';
g='g4';
i=50;					%%número de puntos en algún lado del cuadrado. 
x=linspace(0,1,i);
[xx,yy]=meshgrid(x);
x=zeros(i*i,1);
y=zeros(i*i,1);
for j=0:i-1
	x(j*i+1:(j+1)*i)=xx(:,j+1);
	y(j*i+1:(j+1)*i)=yy(:,j+1);
end
nf= zeros(i*4-4,2);
ni=zeros(i^2-i*4,2);
k=1;
l=1;
x=[x,y];
for j=1:i^2
	if x(j,1)==1||x(j,1)==0||x(j,2)==1||x(j,2)==0
		nf(k,:)=x(j,:);
		k=k+1;
	else
		ni(l,:)=x(j,:);
		l=l+1;
	end
end
x=zeros(i*i,1);
y=zeros(i*i,1);
xv=[ni;nf];
x=xv(:,1);
y=xv(:,2);
z=sin(pi.*(x)).*sin(pi.*(y))+2*x-y;
%z=sin(pi.*(x)).*sin(pi.*(y));%+2*x-y;
tic
tri2=delaunay(x,y);
[mm,mmm]=size(tri2);
%triplot(tri2,x,y)
tn=length(x);
[corte,m]=size(ni);

[veci,trif,trin]=vecinos(tn,tri2,mm,corte);


[A,ig,b]=constru(f,g,tri2,veci,trif,trin,corte,x,y);

x0=ones(corte,1)*1.25;

[alpha,k]=gradconj(A,x0,b);
toc
disp(norm(z(1:corte)-alpha)/norm(z))
frontera=feval(g,x(corte+1:tn),y(corte+1:tn));
%frontera =x(corte+1:tn)*0;
close all
%%%%%%
figure(1)
trimesh(tri2,x,y,[alpha;frontera])
figure(2)
trimesh(tri2,x,y,z)



%norm(alpha-sin(pi*x(1:corte)).*sin(pi*y(1:corte)))/norm(sin(pi*x(1:corte)).*sin(pi*y(1:corte)))
%if flag==1
%	t=linspace(0,1,200);
%	cx=cos(2*pi*t);
%	cy=sin(2*pi*t);
%	close all
%	plot(cx,cy,0.5*cx,0.5*cy);
%	axis equal
%	hold on
%	axis([-1.5 1.5 -1.5 1.5]);
%	triplot(tri2,x,y)
%end


