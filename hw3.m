% author @MiroKurka


% hodnoty zo zadania 
L = 3.5; 
T0 = 20; 
Ts = 20; 
b = 0.0001; 
alphas = [0.2, 0.5, 1]; %
dx = 0.1;
dt = dx**2/(2*alphas(1));

% diskretizacia siete 
nx = round(L/dx) + 1
nt = round(2000./dt) + 1 % 2000 podla intervalu [0,2000] zo zadania


T = zeros(nx, nt);


x = linspace(0, L, nx); % trik prevzaty z matlab fora 
T(:,1) = 20*cos(2*pi*x/5); % teplota tyce na zaciatku 


for a = 1:length(alphas)
    alpha = alphas(a);
    dt = dx**2/(2*alpha);
  for j = 2:nt
      
      T(1,j) = 30*tanh(0.005*(j-1)*dt) + 20; % teplota horuceho konca tyce 
      T(end,j) = Ts;
      for i = 2:nx-1
          T(i,j) = T(i,j-1) + alpha * (T(i+1,j-1) - 2*T(i,j-1) + T(i-1,j-1));
      end
   end
   
     
    
    t_values = round(linspace(1, nt, 5));

    % Neviem preco tato cast kodu nefunguje tak ako ma, tj. nevygeneruju sa 3 grafy podla 
    % poctu alphas 
    for i = 1:length(t_values)
        T_t = T(:, t_values(i));
        plot(x, T_t, 'LineWidth', 2);
        hold on;
    end
    
    xlabel('Pozícia pozdĺž tyče (m)', 'FontSize', 12);
    ylabel('Teplota (\circC)', 'FontSize', 12);
    title(sprintf('Rozdelenie teploty pozdĺž tyče pre alpha = %g', alpha), 'FontSize', 14);
    legend('t = 0', 't = 500', 't = 1000', 't = 1500', 't = 2000', 'Location', 'northwest');
    
    % V tejto casti musim manualne zastavovat ifom ten loop ak chcem graf pre alpha 
    % ak chcem ine ako graf pre poslednu hodnotu z pola alphas tj. alpha= 1
    if alpha == 0.2% 0.5, 1  
        break
    endif
    hold off;
end