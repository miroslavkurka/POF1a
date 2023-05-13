# author @MiroKurka


f = @(x) asin(x) ./ x;

a = 0;
b = 1;


# Uloha a) 
M_values = [ 10 100 1000 10000 100000]; 
I_estimates = zeros(length(M_values),1); 
stdev= zeros(length(M_values),1); # odchylky
sdom = zeros(length(M_values),1);
for i = 1:length(M_values)
    M = M_values(i) # počet bodov pre odhad
    sum_of_func=0;
    d_squared=0;
    for  j=1:M
      x=rand();
      sum_of_func+= f(x); # tu nepotrebujem nasobit rand s  (b-a) odcitavat a lebo je to 1 a 0
      d_squared+= f(x) ** 2;
    endfor
    d_outside_squared= (1/M * sum_of_func) ** 2;
    d_squared = 1/M * d_squared;
    # odchylka
    stdev(i)= d_squared - d_outside_squared;
    
    
    # neskreslena chyba podla vzorca zo zadania 
    true_sigma(i) = sqrt(stdev(i) / (M-1));
    
    # stadard deviation of mean podla zadania "Numericky testujte závislosť MC chyby"

    sdom(i)= true_sigma(i) / sqrt(M);
   
    I_estimates(i)= (b - a)/M * sum_of_func;
    
end

I_estimates
I_real = pi/2*log(2)

logM = log10(M_values);

# Zo zadania nebolo jasne ci zobrazit do errorbarov stadard deviation of mean alebo klasicku
# standard deviation, preto som spravil obidva grafy nizsie
#I_estimates
#sdom
figure;
errorbar(logM, I_estimates, sdom);
xlabel('log(M)');
ylabel('MC hodnoty integralu');
title('Graf závislosti MC hodnot s chybami na počte vzoriek M (SDOM chyba)');

figure;
errorbar(logM, I_estimates, true_sigma);
xlabel('log(M)');
ylabel('MC hodnoty integralu');
title('Graf závislosti MC hodnot s chybami na počte vzoriek M (STD chyba)');

# Uloha b) 


M_values = [ 10 100 1000 10000 100000]; # PRE VELKE M PROGRAM BERIE VELA CPU 
I_estimates = cell(1,length(M_values)); 
sigma_m= zeros(length(M_values),1)
N_seed= 100;
for i = 1:length(M_values)
    M = M_values(i) # počet bodov pre odhad
    sum_of_func=0;
    I_100=zeros(N_seed,1);
  
    for  j=1:N_seed
      # sto odhadov integralu pre kazde M 
      
      # toto je suma od 1 po M v mc odhade (b-a)/M Suma f(nahodne cislo)
      for k=1:M
        x= rand(); # netreba seed podla webu so seed to nefunguje 
        sum_of_func+= f(x);
      endfor 
      I_100(j)= (b - a)/M * sum_of_func;
      sum_of_func=0;
    endfor
    I_100;
    I_estimates{i} = I_100 ;# prirad 100 integralov pre hodnotu M 

    # Vzorec zo zadania
    sigma_m(i) = sqrt(1/N_seed * sum(I_estimates{i}.^2) - (1/N_seed * (sum(I_estimates{i}))**2));
   
    
    
end
sigma_m
logM2=log10(M_values);
figure;
true_sigma
plot(logM2, log10(sigma_m), logM2, log10(true_sigma));
xlabel('log(M)');
ylabel('log(\sigma M )');
title('Graf závislosti \sigma M a hodnot M v log skale');




