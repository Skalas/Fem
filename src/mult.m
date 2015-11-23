function Ap=mult(A,p) 
[n,m]=size(A);
%n1=length(p);
%if n1~=n 
%	error('Los tamaños no coinciden');
%end
Ap=zeros(n,1);
for i =1:n;
	j=1;
	while j< m && A(i,j+1)~=0
		Ap(i)=Ap(i)+A(i,j)*p(A(i,j+1));
		j=j+2;
	end
end
