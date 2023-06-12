# author @MiroKurka

f = @(y,x) x/y^3;


dx = 0.1;
#dx = 0.01; #uncomment step for better solution
N=9; #<-- ZMENA 


x = zeros(N+1,1);
y_euler = zeros(N+1,1);
y_Heun = zeros(N+1,1);
y_analytical= zeros(N+1,1);
exact_solution= @(x) (2*x.^2-1).^(1/4);

x(1) = 1;
y_euler(1) = 1;
y_Heun(1) = 1;


for i=1:N+1 #<-- ZMENA 
    x(i+1) = x(i) + dx;
    y_euler(i+1) = y_euler(i) + dx*f(x(i),y_euler(i));
    y_temp = y_Heun(i) + dx*f(x(i),y_Heun(i));
    y_Heun(i+1) = y_Heun(i) + 0.5*dx*(f(x(i),y_Heun(i)) + f(x(i+1),y_temp));
    if x(i+1) >= 10 #<-- ZMENA 
        break;
    end
end

% Solve the differential equation using lsode()
tspan = linspace(1, 1+N*dx, N+1); # code taken from MATLAB forums
y_lsode = lsode(f, 1, tspan);

if dx == 0.1
  x_al = 1:0.1:2.2; 
else
  x_al = 1:0.01:1.1;
end

y_analytical=exact_solution(x_al);

plot(x_al,y_analytical,'-x',tspan,y_lsode,'-o');
xlabel('x')
ylabel('y')
title(sprintf('Solution of f = x/y^3 using step dx=%.2f', dx))
legend('Analytical solution','lsode()','Location','southeast');

figure() 
plot(x,y_euler,'-o',x,y_Heun,'-x')#,x_al,y_analytical);
xlabel('x');
ylabel('y');
title(sprintf('Solution of f = x/y^3 using step dx=%.2f', dx))
legend('Euler Method', 'Heun Method','Analytical solution','Location','southeast');


figure() 
plot(x,y_euler,'-o',x,y_Heun,'-x',tspan,y_lsode);
xlabel('x');
ylabel('y');
title(sprintf('Solution of f = x/y^3 using step dx=%.2f', dx))
legend('Euler Method', 'Heun Method','lsode()','Location','southeast');
