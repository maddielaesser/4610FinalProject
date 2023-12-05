%% BURGER'S EQUATION
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
s = zeros(nx,nt);
s(:,1) = 5*exp(-(.005*x-2.5).^2);
for k = 1:nt-1
    for i = 2:nx-1
        s(i,k+1) = -C*(s(i,k)).^2 + s(i,k) * (1+C*s(i-1,k)-2*D)+D*(s(i+1,k)+s(i-1,k));
    end
    s(1,k+1) = s(2,k+1);
    s(end,k+1) = s(end-1,k+1);
end
plot(x,s(:,1:500:end));
xlabel('X');
ylabel('Height');
title('Height at each point over time');

%% Multiplication in source term
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
    s(1,k+1) = s(1,k) - C*(s(end,k)).^2 + s(end,k) * (C*s(end-1,k)+2*D*(K(end)-1)) - D*(K(end)-1)*(s(end-1,k)+s(2,k));
    s(end,k+1) = s(1,k);
end
plot(x,s(:,1:500:end));
xlabel('X');
ylabel('Height');
title('Heighgt at each point over time');
%% CONVOLUTION TERM
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
K = (x.^(-1/3))';
s = zeros(nx,nt);
s(:,1) = 5*exp(-(.005*x-2.5).^2);
y1 = zeros(nx-2,1);
y2 = zeros(nx-2,1);
for k = 1:nt-1
    for i = 2:nx-2
        s(i,k+1) = -C*(s(i,k)).^2 + s(i,k) * (1 + C*s(i-1,k)+2*D*(K(i)-1)) - D*(K(i)-1)*(s(i-1,k)+s(i+1,k));
    end
    ii = 2:nx-2;
    y1(1:end-1) = (s(ii(end:-1:1)+1,k)-2*s(ii(end:-1:1),k)+s(ii(end:-1:1)-1,k)).*K(ii);
    y2(2:end) = s(ii(end:-1:1)+2,k)-2*s(ii(end:-1:1)+1,k)+s(ii(end:-1:1),k).*K(ii+1);
    y1(end) = y2(end);
    y2(1) = y1(1);  
    s(2:nx-1,k+1)=s(2:nx-1,k+1) - (1/2*dx*sum(y1+y2));
    s(1,k+1) = s(2,k+1);
    s(end,k+1) = s(end-1,k+1);
end
plot(x,s(:,1:500:end));
xlabel('X');
ylabel('Height');
title('Height at each point over time');
