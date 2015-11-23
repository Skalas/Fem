%% Funcion Gradiente conjugado, Recibe A matriz rala, 
%% x0 que es el punto inicial, y b el vector de la derecha.
%% Todos vectores columna.Modificamos el metodo del 
%% gradiente conjugado para recibir una matriz con solo 
%% las entradas distintas de cero.
function [xk,k]=gradconj(A,xk,b)
    rk = mult(A,xk) - b; 
    pk = -rk; 
    k = 0;
    while norm(rk) >1e-10
    	v=mult(A,pk);
    	alphak=(rk'*rk)/(pk'*v);
     	xk1 =  xk + alphak*pk ;
    	rk1 = rk + alphak  * v ;
    	betak1 = (rk1'*rk1)/(rk'*rk);
    	pk1=-rk1+betak1*pk;
    	xk=xk1;
    	rk=rk1;
    	pk=pk1;
    	k=k+1;
    end
end
