%Objetivo: Gerar um sinal, fazer sua autocorrelação e fazer a transformada
%de Fourier 

clc
clear all
close all

%gera um vetor de valores 0 e 1 de uma linha e 100000 colunas
%multiplica por dois e subtrai 1 para gera um vetor de -1 e 1
info = randi([0 1],1,1e3)*2-1;

%gera um sinal de puslsos retangulares
% a função matlab pede o parametro nsamp que é numero de amostras para formar o sinal retangular, 
%caso contrario será apenas uma amostra e ele irá gerar um sinal triangular 
info_format = rectpulse(info,100);


%info(1,1:10)
figure(1)
subplot(211)
plot(info)

%faz a correlação do sinal com a réplica dele deslocada
Rx = xcorr(info_format);


Gx = fft(Rx);
%fftshift para vizualizar o espectro par
Gx = fftshift(Gx);

subplot(212)
plot(abs(Gx))

