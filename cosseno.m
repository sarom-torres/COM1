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
y = 2 + cos(2*pi*f*t)+5*cos(4*pi*f*t);
subplot(211)
plot(t,y)

%-------------------------------------------------------------
axis([0 3/f -5 10]) %para ajustar os eixos e visualizar apenas o primeiro período

%------------------------------------------------------------- |
%transformada de fourrier
Y = fft(y)/length(y);
subplot(212)
plot(freq,abs(fftshift(Y))) % para deslocar e plotar o módulo no gráfico
axis([-3000 3000 -5 5])

%---------------------------------------------------------------|
%Potência
pot_y = sum(y.^2)/length(y)

