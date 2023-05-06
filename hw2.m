% author: @miroslavkurka
graphics_toolkit("gnuplot");
dt = 0.02;
O_0=1;
w_0=0.1;

n=1000;
% initial vector of first values [0;01]
x = [O_0;w_0];




% matrix for storing solutions, it goes from 2 since solutions for 1 is provided 
X= zeros(2,n);
X(:, 1) = x; % save the initial vector to the first column
V=  [0, 1; -0.5, 0]; % this is due to 2.23 in Zukovic POF textbook

for i = 2:n
  x = x + dt * V * x;
  X(:, i) = x;
  
end;


t_final = 20;
N = round(t_final/dt);
X_k = zeros(2, N+1);
x_k = [O_0;w_0];
X_k(:, 1) = x_k;


for i = 1:N
    k1 = V*X_k(:, i);
    k2 = V*(X_k(:, i) + (dt/2)*k1);
    k3 = V*(X_k(:, i) + (dt/2)*k2);
    k4 = V*(X_k(:, i) + dt*k3);
    X_k(:, i+1) = X_k(:, i) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);
end

% I had problem with trying to use lsode so then i had to "borrow code" from matlab stackexchange
% below code is not original from me
function dx = myode(x_ls, t)
    dx = [x_ls(2); -0.5*x_ls(1)];
end
%x_ls
t_lsode = linspace(0, t_final, N+1);
y_lsode = lsode(@myode, [O_0 w_0], t_lsode);


t = 0:dt:t_final;

t_e = linspace(0, n*dt, n);
subplot(2, 1, 1);
plot(t, X_k(1,:), 'r-', t_e, X(1,:), 'b--', t_lsode, y_lsode(:,1), 'g:','linewidth', 2.5);
title('Porovnanie metód')
xlabel('Čas');
ylabel('Uhol \theta [rad]');
legend('RK metóda', 'Eulerova metóda', 'lsode() metóda');

subplot(2, 1, 2);
plot(t, X_k(2,:), 'r-', t_e, X(2,:), 'b--', t_lsode, y_lsode(:,2), 'g:','linewidth', 2.5);
title('Porovnanie metód')
xlabel('Čas');
ylabel('Uhlová rýchlosť \omega [rad/s]');
legend('RK metóda', 'Eulerova metóda', 'lsode() metóda');
