x0 = 0;
xf = 1000;
t0 = 0;
tf = 100;
dx = 1;
dt = .01;
C = dt/dx;
D = dt/dx.^2;
nx = (xf-x0)/dx;
nt = (tf-t0)/dt;
x = linspace(x0,xf,nx);
t = linspace(t0,tf,nt);
K = x.^(-1/3);
s = zeros(nx,nt);
s(:,1) = 5*exp(-(.005*x-2.5).^2);
for k = 1:nt-1
    for i = 2:nx-1
        s(i,k+1) = -C*(s(i,k)).^2 + s(i,k) * (1 + C*s(i-1,k)+2*D*(K(i)-1)) - D*(K(i)-1)*(s(i-1,k)+s(i+1,k));
    end
    s(1,k+1) = s(2,k+1);
    s(end,k+1) = s(end-1,k+1);
end
plot(x,s(:,1:500:end));
xlabel('X');
ylabel('Height');