clc
clear all
close all

%gerando numero aleatorios com distribuição normal
ruido = randn(1,1000e3);
maior = max(ruido);
media = mean(ruido);
variancia = var(ruido);
hist(ruido,100);
%valor medio quadrático
Ex2 = sum(ruido.^2)/length(ruido)

%para deslocar a média
ruido_desloc = ruido + 5;
hist(ruido_desloc,100);
Ex2_r = sum(ruido_desloc.^2)/length(ruido_desloc);

%calculando desvio padrão
ruido2 = sqrt(10)*ruido;
var(ruido2);

%-------------------------------------
%gerando um ruido somado a um sinal

info = randi([0 1],1,1e3)*2-1;

info_format = rectpulse(info,100);

var = 0.1
ruido = rand(1,length(info_format));
r = info_format + ruido;
plot(r)
xlim([0 1500]);

