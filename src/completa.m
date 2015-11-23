function B=completa(A)
[n,m]=size(A);
B=zeros(n,n);
for i=1:n
    s=1;
    while s<m+1&& A(i,s+1)~=0
        B(i,A(i,s+1))=A(i,s);
        s=s+2;
    end
end
