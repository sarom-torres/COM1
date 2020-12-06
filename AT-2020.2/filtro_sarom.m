#-----------------------------|
#   ATIVIDADE FILTROS IDEAIS  |
#   SAROM TORRES              |
#-----------------------------|

clc;close all;clear all;

#-----------------------------|
#      Tempo e Frequência     |
#-----------------------------|
f1 = 1e3;
f2 = 3e3;
f3 = 5e3;
N = 100;
fs = N*f1;

ts = 1/fs;
t_final = 0.5;
t = [0:ts:t_final];
passo_f = 1/t_final;

f = [-fs/2:passo_f:fs/2];

#-----------------------------|
#         Filtros             |
#-----------------------------|
Filtro_PB = [zeros(1,24e3) ones(1,2001) zeros(1,24e3)];
Filtro_PF = [zeros(1,23e3) ones(1,1e3) zeros(1,2001) ones(1,1e3) zeros(1,23e3)];
Filtro_PA = [ones(1,23e3) zeros(1,4001) ones(1,23e3)];

#-----------------------------|
#           Sinal             |
#-----------------------------|
A = 6;
y = A*cos(2*pi*f1*t) + (A/2)*cos(2*pi*f2*t) + (A/3)*cos(2*pi*f3*t);

T = length(y);
Y = fft(y);
Y = fftshift(Y);
Y = abs(Y);

#-----------------------------|
#         Filtragem           |
#-----------------------------|
Filtragem_PB = Y.*Filtro_PB; 
Filtragem_PF = Y.*Filtro_PF;
Filtragem_PA = Y.*Filtro_PA;

#----------------------------------|
#  Figura 1 - Sinais e Espectros   |
#----------------------------------|
figure(1)
subplot(211)
plot(1e3*t,y)
axis([0 3 -2*A 2*A])
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('Sinal y(t)');

subplot(212)
plot(f/1e3,Y/T,'-o')
axis([-(f3/1e3)-2 (f3/1e3)+2 0 A/1.5])
xticks([-5 -3 -1 0 1 3 5])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('Espectro de frequências de y(t)');

#---------------------------------|
#      Figura 2 - Filtros         |
#---------------------------------|
figure(2)
subplot(311)
plot(f/1e3,Filtro_PB,'r','LineWidth',3)
axis([-6 6 0 1.2])
xticks([-4 -2 0 2 4])
xlabel('Frequência (kHz)');
title('Filtro Passa Baixa Ideal com Wc de 2kHz');

subplot(312)
plot(f/1e3,Filtro_PF,'g','LineWidth',3)
axis([-6 6 0 1.2])
xticks([-4 -2 0 2 4])
xlabel('Frequência (kHz)');
title('Filtro Passa Faixa Ideal com Wc de 2kHz a 4KHz');

subplot(313)
plot(f/1e3,Filtro_PA,'m','LineWidth',3)
axis([-6 6 0 1.2])
xticks([-4 -2 0 2 4])
xlabel('Frequência (kHz)');
title('Filtro Passa Alta Ideal com Wc 4KHz');

#--------------------------------|
#      Figura 3 - Filtragem      |
#--------------------------------|
figure(3)
subplot(311)
plot(f/1e3,Filtragem_PB/T,'-ro','LineWidth',2)
axis([-6 6 0 4])
xticks([-5 -3 -1 0 1 3 5])
xlabel('Frequência (kHz)');
title('Espectro do sinal y(t) filtrado com PB Ideal com Wc de 2kHz');

figure(3)
subplot(312)
plot(f/1e3,Filtragem_PF/T,'-go','LineWidth',2)
axis([-6 6 0 4])
xticks([-5 -3 -1 0 1 3 5])
xlabel('Frequência (kHz)');
title('Espectro do sinal y(t) filtrado com PF Ideal com Wc de 2kHz');

figure(3)
subplot(313)
plot(f/1e3,Filtragem_PA/T,'-mo','LineWidth',2)
axis([-6 6 0 4])
xticks([-5 -3 -1 0 1 3 5])
xlabel('Frequência (kHz)');
title('Espectro do sinal y(t) filtrado com PA Ideal com Wc de 2kHz');



