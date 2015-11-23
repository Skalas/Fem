%% [x0,x1,x2,xt1,xt2,xt3]=puntos(x,y,t,loc,ig)
% x y son las coordenadas de todos los puntos. 
% t es el vector con los tres puntos necesarios.
% loc es el lugar en t donde está el nodo actual. 
% ig booleano para saber si estamos calculando la matriz o el vector de la derecha.
% xi son los puntos del plano R^3
% xti son los puntos en el plano R^2
% función para evaluar los puntos con el switch.


function [x0,x1,x2,xt0,xt1,xt2]=puntos(x,y,t,loc,front,tr,corte,gname)
if tr==1
    
end
if front==0
    x0=[x(t(loc)),y(t(loc)),1]';			%%% Construímos el primer punto (con altura 1) para poder calcular la mult de los grads. 
	xt0=[x(t(loc)),y(t(loc))]';			%%% Para poder sacar el área del triángulo. 
    switch loc                              %%% el switch es en función de que parte del triangulo está el nodo donde estamos. 
			case 1
				x1=[x(t(2)),y(t(2)),0]';		
				x2=[x(t(3)),y(t(3)),0]';
				xt1=[x(t(2)),y(t(2))]';
				xt2=[x(t(3)),y(t(3))]';
			case 2 
				x1=[x(t(1)),y(t(1)),0]';
				x2=[x(t(3)),y(t(3)),0]';
				xt1=[x(t(1)),y(t(1))]';
				xt2=[x(t(3)),y(t(3))]';
			
			case 3
				x1=[x(t(2)),y(t(2)),0]';
				x2=[x(t(1)),y(t(1)),0]';
				xt1=[x(t(2)),y(t(2))]';
				xt2=[x(t(1)),y(t(1))]';
	end			
else
    xt0=[x(t(loc)),y(t(loc))]';	
    switch loc                              %%% el switch es en función de en que parte del triangulo está el nodo donde estamos. 
        case 1
			x0=[x(t(1)),y(t(1)),0]';
            if t(2)>corte
                x1=[x(t(2)),y(t(2)),feval(gname,x(t(2)),y(t(2)))]';
            else
                x1=[x(t(2)),y(t(2)),0]';
            end
            if t(3)>corte
                x2=[x(t(3)),y(t(3)),feval(gname,x(t(3)),y(t(3)))]';
            else
                x2=[x(t(3)),y(t(3)),0]';
            end
            xt1=[x(t(2)),y(t(2))]';
			xt2=[x(t(3)),y(t(3))]';

        case 2 	
            x0=[x(t(2)),y(t(2)),0]';
            if t(1)>corte
                x1=[x(t(1)),y(t(1)),feval(gname,x(t(1)),y(t(1)))]';
            else
                x1=[x(t(1)),y(t(1)),0]';
            end
            if t(3)>corte
                x2=[x(t(3)),y(t(3)),feval(gname,x(t(3)),y(t(3)))]';
            else
                x2=[x(t(3)),y(t(3)),0]';
            end
            xt1=[x(t(1)),y(t(1))]';
			xt2=[x(t(3)),y(t(3))]';
        case 3
            x0=[x(t(3)),y(t(3)),0]';
            if t(2)>corte
                x1=[x(t(2)),y(t(2)),feval(gname,x(t(2)),y(t(2)))]';
            else
                x1=[x(t(2)),y(t(2)),0]';
            end
            if t(1)>corte
                x2=[x(t(1)),y(t(1)),feval(gname,x(t(1)),y(t(1)))]';
            else
                x2=[x(t(1)),y(t(1)),0]';
            end
            xt1=[x(t(2)),y(t(2))]';
			xt2=[x(t(1)),y(t(1))]';
    end	
end

end

