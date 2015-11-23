%%%% script de pueba para la fórmula de la ig
%%% en el origen
x0=[0,0,1]';
x2=[-1/9,0,0]';
x1= [0,-1/9,0]';
c1=0;

fname='fname1';  %fname1 es la clavada en el origen. 
	b1=(x0+x1)/2;
	b2=(x0+x2)/2;
	b3=(x1+x2)/2;
	a123=(x0+x1+x2)/3;
	a=area(x0(1:2),x1(1:2),x2(1:2));
 	c1=c1+a/20*(feval(fname,x0))+ 2*a/15*(feval(fname,b1)*plano(b1,x0,x1,x2)+feval(fname,b2)*plano(b2,x0,x1,x2)+feval(fname,b3)*plano(b3,x0,x1,x2))+ 9*a/20*feval(fname,a123)*plano(a123,x0,x1,x2)
 	
%x0=[5/9,2/3,1]';
%x1=[2/3,7/9,0]';
%x2=[2/3,5/9,0]';
%c=0;

%fname='fname'; % fname es la original sin trasladar. 
%	b1=(x0+x1)/2;
%	b2=(x0+x2)/2;
%	b3=(x1+x2)/2;
%	a123=(x0+x1+x2)/3;
%	a=area(x0(1:2),x1(1:2),x2(1:2));
% 	c=c+a/20*(feval(fname,x0))+ 2*a/15*(feval(fname,b1)*plano(b1,x0,x1,x2)+feval(fname,b2)*plano(b2,x0,x1,x2)+feval(fname,b3)*plano(b3,x0,x1,x2))+ 9*a/20*feval(fname,a123)*plano(a123,x0,x1,x2) 	
% 	
% 	
