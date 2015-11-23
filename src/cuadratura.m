%% Funcion que calcula la integral por medio de la cuadratura.
function c = cuadratura(fname,i,tri,tri2,x,y)
	l=1;
	c=0;
	while tri(l)~=0
		t=tri2(tri(l),:); 
		%% Encontramos donde esta el que queremos. para el nodo i
		%% encontramos la pocision sobre el triangulo.
		[x0,loc]=min(abs(t-i)); 
		x0=[x(t(loc)),y(t(loc)),1]';
		switch loc
			case 1
				x1=[x(t(2)),y(t(2)),0]';		
				x2=[x(t(3)),y(t(3)),0]';
			case 2 	
				x1=[x(t(1)),y(t(1)),0]';
				x2=[x(t(3)),y(t(3)),0]';
			case 3
				x1=[x(t(2)),y(t(2)),0]';
				x2=[x(t(1)),y(t(1)),0]';
		end
		b1=(x0+x1)/2;
		b2=(x0+x2)/2;
		b3=(x1+x2)/2;
		a123=(x0+x1+x2)/3;
		a=area(x0(1:2),x1(1:2),x2(1:2));
	 	c=c+ a/20*(feval(fname,x0(1:2)))+...
	 	  2*a/15*(feval(fname,b1(1:2))*plano(b1(1:2),x0,x1,x2)+...
	 	  feval(fname,b2(1:2))*plano(b2,x0,x1,x2)+...
	 	  feval(fname,b3(1:2))*plano(b3(1:2),x0,x1,x2))+ ...
	 	  9*a/20*feval(fname,a123(1:2))*plano(a123,x0,x1,x2);
	    l=l+1;
	end
end

