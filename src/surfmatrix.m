%%  Fijar Parametros
%%  Definicion de las funciones de la ecuacion.
f = 'fn';              
g = 'g5';
%%  Numero de puntos sobre el circulo.
fineza = 200;
nc = 5;
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
[alpha,k] = gradconj(A,x0,b);
toc
Ap=completa(A);
imagesc(Ap)
