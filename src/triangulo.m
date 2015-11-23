%%% Funcion que calcula en funcion de el numero de circulos
%%% y del numero de puntos sobre los circulos la triangulacion
%%% los nodos, cuales son nodos interiores, cuales son nodos 
%%% frontera, y el numero de triangulos finales de la 
%%% triangulacion. 
function [x,y,tri2,ni,nf,mm]=triangulo(fineza,nc)
t=linspace(0,1,fineza+1);
x=[];
y=[];
%% Creamos los nodos en la frontera, tanto interna como externa.
t=t(1:fineza);
cx1=sqrt(0.5)*cos(2*pi*t);
cy1=sqrt(0.5)*sin(2*pi*t);
t=linspace(0,1,2*fineza+1);
t=t(1:2*fineza);
cx4=cos(2*pi*t);
cy4=sin(2*pi*t);
nf=[cx1,cx4;cy1,cy4]';

%% Vamos incrementando poco a poco el radio de los circulos 
%% para generar los puntos interiores del conjunto de interes.

for i = 1 : nc
  cambio=floor(fineza*(1+i/(nc+1)));
	t=linspace(0,1,cambio+1);
	t=t(1:cambio);
 	cxi=((sqrt(0.5)+(1-sqrt(0.5))*i/(nc+1)))*cos(2*pi*t);
	cyi=((sqrt(0.5)+(1-sqrt(0.5))*i/(nc+1)))*sin(2*pi*t);
	x=[x,cxi];
	y=[y,cyi];
end
%% Pegamos los nodos en un mismo vector. 
ni=[x;y]';	
x=[x,cx1,cx4]';
y=[y,cy1,cy4]';

%% Aqui se genera la triangulacion con el algoritmo delaunay(x,y)
%% funcion de Matlab.
tri=delaunay(x,y);
[m,n]=size(tri);

indices=ones(m,1);
%% Vamos triangulo por triangulo buscando si estan  dentro
%% o fuera del dominio, si estan fuera, los sacamos de la 
%% triangulacion. 
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