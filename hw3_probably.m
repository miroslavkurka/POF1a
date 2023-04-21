L = 3.5; % length of the rod
T0 = 20; % temperature at the beginning of the rod (t = 0)
Ts = 20; % temperature at the end of the rod (x = L)
b = 0.0001; % diffusion coefficient
alphas = [0.2, 0.5, 1]; % calculation coefficients
dx = 1; % spatial step size
dt = 20 % time step size

% calculate number of points in space and time
nx = round(L/dx) + 1;
nt = round(2000./dt) + 1;

% initialize temperature arrays
T = zeros(nx, nt);

% set initial conditions
x = linspace(0, L, nx);
T(:,1) = 20*cos(2*pi*x/5);

% iterate over time and space and calculate temperature
for a = 1:length(alphas)
    alpha = alphas(a);
  for j = 2:nt
      % apply the boundary condition at x=0
      T(1,j) = 30*tanh(0.005*(j-1)*dt) + 20;
      % apply the boundary condition at x=L
      T(end,j) = Ts;
      % update the temperature profile in the interior
      for i = 2:nx-1
          T(i,j) = T(i,j-1) + alpha * (T(i+1,j-1) - 2*T(i,j-1) + T(i-1,j-1));
      end
   end
   
     
    % select time values for plotting
    t_values = round(linspace(1, nt, 5));

    % plot temperature distribution along the rod for each time value
    for i = 1:length(t_values)
        % get temperature profile at given time
        T_t = T(:, t_values(i));
        % plot temperature profile
        plot(x, T_t, 'LineWidth', 2);
        hold on;
    end
    
    % add labels and legend
    xlabel('Pozícia pozdĺž tyče (m)', 'FontSize', 12);
    ylabel('Teplota (\circC)', 'FontSize', 12);
    title(sprintf('Rozdelenie teploty pozdĺž tyče pre alpha = %g', alpha), 'FontSize', 14);
    legend('t = 0', 't = 500', 't = 1000', 't = 1500', 't = 2000', 'Location', 'northwest');
    
    if alpha == 0.2
        break
    endif
    % clear plot for next iteration
    hold off;
end