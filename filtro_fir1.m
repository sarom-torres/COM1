%Objetivo : Filtro de sinal no dominio do tempo usando a função fir do
%matlab

clc
clear all
close all

%------------------------------------------------------------- |período
f = 1e3; %frequencia do seno
N = 200; %fator de super amostragem
fs = N*f; %frequencia de amostragem
num_periodo = 250; %numero de periodos
t_final = num_periodo*(1/f);
Ts = 1/fs; %tempo de amostragem (espaço entre as amostras)
t = [0:Ts:t_final]; %subtrai Ts para remover a 41 amostra
passo_f = 1/t_final; %para vincular o sinal de entrada com o gráfico da frequencia
freq = [-fs/2:passo_f:fs/2];

%-------------------------------------------------------------- | plot seno
A = 6;
y = cos(2*pi*f*t) + cos(2*pi*3*f*t)+ cos(2*pi*5*f*t);
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
%filtro no tempo 

%fir1(ordem do filtro,frequencia de corte)
% função só aceita entradas no segundo argumento de zero a um
% para isso é necessario normalizar a frequencia para deixar ela entre 0 e
% 1 entao fazer a (frequencia de corte*2)/frequencia de amostragem
%fornece um filtro no tempo. No outro filtro feito a mao o filtro era na
%frequencia
%para o filtro ser um sync basta diminuir o numero de amostragem
filtro = fir1(50,(1500*2)/fs);

figure(4)
stem(filtro)

%---------------------------------------------------------------|
%convolução do filtro com o sinal
y_filtrado = conv(y,filtro); 
figure(5)
subplot(211)
plot(y)
xlim([0 1000])
subplot(212)
plot(y_filtrado)
xlim([0 1000])

%mostra as frequencias da transformada z do filtro
figure(6)
freqz(filtro)

%---------------------------------------------------------------|
%Potência
pot_y = sum(y.^2)/length(y);
