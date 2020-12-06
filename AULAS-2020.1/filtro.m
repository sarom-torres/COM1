clc
clear all
close all

%OBJETIVO: fazer um filtro passa-baixa de 1,5Khz no dominio da frequencia

%------------------------------------------------------------- |período
f = 1e3; %frequencia do seno
N = 200; %fator de super amostragem
fs = N*f; %frequencia de amostragem
num_periodo = 250; %numero de periodos
t_final = num_periodo*(1/f);
Ts = 1/fs; %tempo de amostragem (espaço entre as amostras)
t = [0:Ts:t_final]; 
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
Y = fftshift(Y);
subplot(212)
plot(freq,abs(Y)) % para deslocar e plotar o módulo no gráfico
axis([-3000 3000 -5 5])

%---------------------------------------------------------------|
%Potência
pot_y = sum(y.^2)/length(y)

% Para saber o tamanho do filtro tem que saber a posição da frequencia de
% 1,5k no vetor  
% Se o passo fosse um a posição seria 98,5k, mas o passo é 4 entao divide
% esse valor por 4
% Se o passo fosse 1 o vetor seria prenchido de 1s pela largura da banda que é 3k
% como o passo é quatro divide a banda por 4
% Após esse valor de preenche de zero novamente

%banda = 3e3;
%fc = 

filtro_PB = [zeros(1,24625) ones(1,751) zeros(1,24625)]; 
y_filter = abs(Y).*filtro_PB;
figure(2)
subplot(311)
plot(freq,filtro_PB)
ylim([0 1.5])
xlim([-10e3 10e3])

%plot saida do filtro
subplot(312)
plot(freq,y_filter)

% transformada inversa da saida do filtro
y_out = ifft(ifftshift(y_filter));
subplot(313)
plot(t,(y_out))
xlim([0 3/f])
