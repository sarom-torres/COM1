clc
clear all
close all

%------------------------------------------------------------- |período
f = 1e3; %frequencia do seno
N = 2000; %fator de super amostragem
fs = N*f; %frequencia de amostragem
num_periodo = 250; %numero de periodos
t_final = num_periodo*(1/f);
Ts = 1/fs; %tempo de amostragem (espaço entre as amostras)
t = [0:Ts:t_final]; %subtrai Ts para remover a 41 amostra
passo_f = 1/t_final; %para vincular o sinal de entrada com o gráfico da frequencia
freq = [-fs/2:passo_f:fs/2];

%-------------------------------------------------------------- | plot seno
A = 6;
y = A*sin(2*pi*f*t)+(A/3)*sin(2*pi*3*f*t)+(A/5)*sin(2*pi*5*f*t)+(A/7)*sin(2*pi*7*f*t)+(A/9)*sin(2*pi*9*f*t);
subplot(211)
plot(t,y)

%-------------------------------------------------------------
axis([0 5/f -1.5*A 1.5*A]) %para ajustar os eixos e visualizar apenas o primeiro período

%------------------------------------------------------------- |
%tranformada de fourrier
Y = fft(y)/length(y);
subplot(212)
plot(freq,abs(fftshift(Y))) % para deslocar e plotar o módulo no gráfico
axis([-12*f 12*f 0 1*A])

