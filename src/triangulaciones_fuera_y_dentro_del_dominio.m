f='fn';              %%% cambiar las funciones
g='g5';
fineza=50;              %%% Número de puntos sobre el círculo. 
nc=2;


t=linspace(0,1,fineza+1);
x=[];
y=[];

%Nodos frontera.

t=t(1:fineza);

cx1=sqrt(0.5)*cos(2*pi*t);
cy1=sqrt(0.5)*sin(2*pi*t);
t=linspace(0,1,2*fineza+1);
t=t(1:2*fineza);
cx4=cos(2*pi*t);
cy4=sin(2*pi*t);
nf=[cx1,cx4;cy1,cy4]';

%nodos interiores
for i = 1 : nc
    cambio=floor(fineza*(1+i/(nc+1)));
	t=linspace(0,1,cambio+1);
	t=t(1:cambio);
 	cxi=((sqrt(0.5)+(1-sqrt(0.5))*i/(nc+1)))*cos(2*pi*t);
	cyi=((sqrt(0.5)+(1-sqrt(0.5))*i/(nc+1)))*sin(2*pi*t);
	x=[x,cxi];
	y=[y,cyi];
end
ni=[x;y]';	
x=[x,cx1,cx4]';
y=[y,cy1,cy4]';

%triangulación.
tri=delaunay(x,y);
[m,n]=size(tri);

indices=ones(m,1);
for k=1:m
    centro_x=(x(tri(k,1))+x(tri(k,2))+x(tri(k,3)))/3;
    centro_y=(y(tri(k,1))+y(tri(k,2))+y(tri(k,3)))/3;
     r2=  centro_x^2 + centro_y^2;
     if r2<0.5 || r2>1 
         indices(k)=0;
     end
end
mm=sum(indices);
tri2=zeros(mm,3);
cont=0;
for k=1:m
   if indices(k)==1
       cont=cont+1;
       tri2(cont,:)=tri(k,:);
   end
end
figure(1)
triplot(tri,x,y,'Color',[0,0.4,0.2])
axis equal
axis([-1.1 1.1 -1.1 1.1])
figure(2)
triplot(tri2,x,y,'Color',[0,0.4,0.2])
axis equal
axis([-1.1 1.1 -1.1 1.1])