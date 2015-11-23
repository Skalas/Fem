%%  Fijar Parametros
%%  Definicion de las funciones de la ecuacion.
f = 'fn';              
g = 'g5';
%%  Numero de puntos sobre el circulo.
fineza = 50;
nc = 3;
tic
%%  La funcion triangulo nos da la triangulacion y 
%%  otros datos necesarios.
[x,y,tri2,ni,nf,mm] = triangulo(fineza,nc);
%%  En este caso conocemos la solucion de la ecuacion
%%  usaremos z para medir el comportamiento del algoritmo
z = u5(x,y);
%%  Procesar datos 
tn = length(x);
[corte,m] = size(ni);
%%  Vecinos nos da los vecinos de cada nodo, triangulos internos
%%  triangulos frontera 
[veci,trif,trin] = vecinos(tn,tri2,mm,corte);
%%  Construir el sistema de ecuaciones.
[A,ig,b] = constru(f,g,tri2,veci,trif,trin,corte,x,y);
%%  Resolver el sistema de ecuaciones.
x0 = ones(corte,1)*1.25;
%% En este punto es donde se podria cambiar el metodo de solucion
%% del sistema lineal.
[alpha,k] = gradconj(A,x0,b);
toc
%%  Presentar resultados.
norm(z(1:corte)-alpha)/norm(z)
frontera = feval(g,x(corte+1:tn),y(corte+1:tn));
close all
%%  Graficar los resultados.
close all 
figure
figure(1)
trisurf(tri2,x,y,[alpha;frontera])
figure(2)
trisurf(tri2,x,y,z)
figure(3)
triplot(tri2,x,y,'Color',[0,0.4,0.2])
axis equal
axis([-1.1 1.1 -1.1 1.1])
