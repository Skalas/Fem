%%% funcion que recibe tres puntos y 
%%% calcula el area que delimitan.
%%% x,y,z puntos en el plano. 
%%% a area total dada por los puntos.
function a=area(x,y,z)
    ac=x-y;
    ab=z-y;
    nab=[ab(2),-ab(1)];
    a=abs(nab*ac)/2;
end