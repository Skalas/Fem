%%% Funcion que para cada nodo encuentra todos los 
%%% vecinos y a los triangulos por el cual es vecino
%%% del nodo en cuestion. 

function [veci,trif,trin]=vecinos(tn,tri2,mm,corte)

trin=zeros(tn,10);
veci=zeros(corte,2*16);
trif=zeros(corte,8);
%% En los for's se itera sobre todos los nodos y 
%% encontramos los vecinos y de que triangulos 
%% son vecinos.  Ademas de clasificar a los 
%% triangulos en fronterizos e interiores.
for i =1:mm
	for j = 1:3
		l=1;
		while trin(tri2(i,j),l)~=0
			l=l+1;
		end
		trin(tri2(i,j),l)=i;
	end
end

for i =1:corte
	l=1;
	while trin(i,l)~=0
		for j=1:3
			s=1;
			if tri2(trin(i,l),j)<corte+1 
			
				if tri2(trin(i,l),j)~=i
					while veci(i,s)~=0
						s=s+1;
					end
					%% Sacar el vecino.
					veci(i,s)=tri2(trin(i,l),j);
					%% El numero de triangulo que 
					%% esta.    
					veci(i,s+1)=trin(i,l);		
				end
			else
				while trif(i,s)~=0 && trif(i,s)~=trin(i,l)
					s=s+1;
				end
				%% El numero de triangulo que esta.
				trif(i,s)=trin(i,l);		
			end
		end
		l=l+1;
	end
end		