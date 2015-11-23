%%% Constru es una fucion que construye la matriz A y el
%%% vector b para ponerlo en el sistema lineal de ecuaciones. 
%%% Recibe todos los nodos, triangulos, vecinos f y g como 
%%% funciones. (nombres de funciones)

function [A,ig,b]=constru(fname,...
							gname, ...
							tri2, ...
							veci, ...
							trif, ...
							trin, ...
							corte, ...
							x, ...
							y)	
	A=zeros(corte,30);
	t=[0,0,0];
	ig=zeros(corte,1);
	b=zeros(corte,1);
	for i =1: corte
		l=1;
		while  l<32 && veci(i,l)~=0
			%% Aqui sacamos el triangulo veci(i,l) 
			%% es el vecino en el l+1 esta el triangulo. 
			t(1:3)=tri2(veci(i,l+1),:);
			%% Encontramos donde esta el que queremos. 
			%% Para el nodo i encontramos la pocision 
			%% sobre el triangulo.
			[x0,loc]=min(abs(t-i));
			%% Construimos el primer punto (con altura 1) 
			%% para poder calcular la mult de los grads. 
			x0=[x(t(loc)),y(t(loc)),1]';
			%% Para poder sacar el area del triangulo. 
			xtr0=[x(t(loc)),y(t(loc))]';
			%% el switch es en funcion de en que parte 
			%% del triangulo esta el nodo donde estamos. 
			switch loc
				case 1
					x1=[x(t(2)),y(t(2)),0]';		
					x2=[x(t(3)),y(t(3)),0]';
					xtr1=[x(t(2)),y(t(2))]';
					xtr2=[x(t(3)),y(t(3))]';
				case 2 
					x1=[x(t(1)),y(t(1)),0]';
					x2=[x(t(3)),y(t(3)),0]';
					xtr1=[x(t(1)),y(t(1))]';
					xtr2=[x(t(3)),y(t(3))]';
				
				case 3
					x1=[x(t(2)),y(t(2)),0]';
					x2=[x(t(1)),y(t(1)),0]';
					xtr1=[x(t(2)),y(t(2))]';
					xtr2=[x(t(1)),y(t(1))]';
			end
			%% Debemos construir los triangulos y 
			%% la funcion para el vecino, 
			[x00,loc]=min(abs(t-veci(i,l)));
			%% Sacamos con altura 1 el nodo. 
			x01=[x(t(loc)),y(t(loc)),1]';
			switch loc
				case 1
					x11=[x(t(2)),y(t(2)),0]';
					x21=[x(t(3)),y(t(3)),0]';
				case 2 
					x11=[x(t(1)),y(t(1)),0]';
					x21=[x(t(3)),y(t(3)),0]';
				
				case 3
					x11=[x(t(2)),y(t(2)),0]';
					x21=[x(t(1)),y(t(1)),0]';
			end
			s=1;
			%% Busqueda para ver si ya habiamos 
			%% hecho la integral y si no, para 
			%% que encuentre el lugar para guardarlo. 
			while A(i,s)~=0 &&  A(i,s+1)~=veci(i,l)		
				s=s+1;			
	        end
	        %% area del triangulo por el producto de 
	        %% los gradientes.
			A(i,s)=A(i,s)+gradp(x0,x1,x2)'* ...
			 		gradp(x01,x11,x21)*...
			 		area(xtr1,xtr2,xtr0);	
			A(i,s+1)=veci(i,l);
			l=l+2;
		end
		l=1;
	    
	%% A(i,i) Tiene que calcularse aparte 
	%% por cuestiones de que se requieren 
	%% todos los triangulos	
		while l<32 && trin(i,l)~=0 
			t(1:3)=tri2(trin(i,l),:);
			[x0,loc]=min(abs(t-i));
			%% Construimos el primer punto (con altura 1) 
			%% para poder calcular la mult de los grads. 
			x0=[x(t(loc)),y(t(loc)),1]';
			%% Para poder sacar el area del triangulo. 
			xtr0=[x(t(loc)),y(t(loc))]';			
			%% el switch es en funcion de en que parte del 
			%% triangulo esta el nodo donde estamos. 
			switch loc                              
				case 1
					x1=[x(t(2)),y(t(2)),0]';		
					x2=[x(t(3)),y(t(3)),0]';
					xtr1=[x(t(2)),y(t(2))]';
					xtr2=[x(t(3)),y(t(3))]';
				case 2 	
					x1=[x(t(1)),y(t(1)),0]';
					x2=[x(t(3)),y(t(3)),0]';
					xtr1=[x(t(1)),y(t(1))]';
					xtr2=[x(t(3)),y(t(3))]';
				
				case 3
					x1=[x(t(2)),y(t(2)),0]';
					x2=[x(t(1)),y(t(1)),0]';
					xtr1=[x(t(2)),y(t(2))]';
					xtr2=[x(t(1)),y(t(1))]';
	        end
	        
			while A(i,s)~=0 && A(i,s+1)~= i 
				s=s+1;
			end
			A(i,s)=A(i,s)+ gradp(x0,x1,x2)'*gradp(x0,x1,x2)* ...
					area(xtr1,xtr2,xtr0);
			A(i,s+1)=i;
			%% aqui se calcula ig que es el vector que se resta 
			%% al lado derecho para tomar en cuenta una condicion 
			%% de frontera no-homogenea
			if l<32 && trif(i,l)~=0
				%% Aqui guardo los tres triangulos con un nodo
				%% frontera.
				t(1:3)=tri2(trif(i,l),:);
				%% Encontramos la loc donde esta el nodo dentro
				%% del triangulo. 
				[x0,loc]=min(abs(t-i));
				%% Construimos el primer punto (con altura 1) 
				%% para poder calcular la mult de los grads. 
				x0=[x(t(loc)),y(t(loc)),1]';
				%% Para poder sacar el area del triangulo. 
				xtr0=[x(t(loc)),y(t(loc))]';
				%% Practicamente analogo al bloque anterior
				switch loc 
				
					case 1
						x1=[x(t(2)),y(t(2)),0]';		
						x2=[x(t(3)),y(t(3)),0]';
						xtr1=[x(t(2)),y(t(2))]';
						xtr2=[x(t(3)),y(t(3))]';
						x01=[x(t(1)),y(t(1)),0]';
						if t(2)>corte
							x11=[x(t(2)),y(t(2)), ...
								feval(gname,x(t(2)),y(t(2)))]';
						else
							x11=[x(t(2)),y(t(2)),0]';
						end
						if t(3)>corte
							x21=[x(t(3)),y(t(3)), ...
								feval(gname,x(t(3)),y(t(3)))]';
						else
							x21=[x(t(3)),y(t(3)),0]';
						end
						
					case 2 	
						x1=[x(t(1)),y(t(1)),0]';
						x2=[x(t(3)),y(t(3)),0]';
						xtr1=[x(t(1)),y(t(1))]';
						xtr2=[x(t(3)),y(t(3))]';
						x01=[x(t(2)),y(t(2)),0]';
						if t(1)>corte
							x11=[x(t(1)),y(t(1)),...
								feval(gname,x(t(1)),y(t(1)))]';
						else
							x11=[x(t(1)),y(t(1)),0]';
						end
						if t(3)>corte
							x21=[x(t(3)),y(t(3)),...
								feval(gname,x(t(3)),y(t(3)))]';
						else
							x21=[x(t(3)),y(t(3)),0]';
						end
					case 3
						x1=[x(t(2)),y(t(2)),0]';
						x2=[x(t(1)),y(t(1)),0]';
						xtr1=[x(t(2)),y(t(2))]';
						xtr2=[x(t(1)),y(t(1))]';
						x01=[x(t(3)),y(t(3)),0]';
						if t(2)>corte
							x11=[x(t(2)),y(t(2)), ...
								feval(gname,x(t(2)),y(t(2)))]';
						else
							x11=[x(t(2)),y(t(2)),0]';
						end
						if t(1)>corte
							x21=[x(t(1)),y(t(1)),...
								feval(gname,x(t(1)),y(t(1)))]';
						else
							x21=[x(t(1)),y(t(1)),0]';
						end
		
	            end	
	       		ig(i)= ig(i)+ gradp(x0,x1,x2)'* ...
	       				gradp(x21,x11,x01)* ...
	       				area(xtr1,xtr2,xtr0);

			end
			l=l+1;
	    end
	    %% Calculo la integral de la multiplicacion por medio 
	    %% de la cuadratura y se le resta ig.
		b(i)=cuadratura(fname,i,trin(i,:),tri2,x,y)-ig(i);
end
