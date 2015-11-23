%%% Evalua el gradiente de la funcion para 
%%% los planos definidos en un triangulo. 
%%% x0 es el punto con altura 1 o f(nodo).
%%% x1 y x2 son dos puntos sobre el plano 
%%% (con tercera coordenada cero).
function h=gradp(x1,x2,x0)
    a=x1-x2;
    b=x0-x2;
    eta=[a(2).*b(3)-a(3).*b(2) ...
         a(3).*b(1)-a(1).*b(3) ...
         a(1).*b(2)-a(2).*b(1)];
    h=-[eta(1)/eta(3);eta(2)/eta(3)];
end

