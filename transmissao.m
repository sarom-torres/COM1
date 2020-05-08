clear all;close all;clc;

M = 2; #número de níveis de transmissão
#fazer a superamostragem da variavel info com N
#ou seja colocar amostras com valor zero
N = 100; # numero de amostras
limiar = 0.5;
n_bits = 10000;
var_ruido = 0.1;
filtro_NRZ = ones(1,N);#formatador do sinal
info = randint(1,n_bits,M); #informacao a ser transmitida 
info_up = upsample(info,N); #informacao superamostrada
sinal_tx = conv(info_up,filtro_NRZ);
sinal_tx = sinal_tx(1:end-(N-1)); #para truncar



ruido = sqrt(var_ruido)*randn(1,length(sinal_tx));
#Recuperação do sinal
sinal_rx = sinal_tx + ruido;
sinal_det = sinal_rx(N/2:N:end);
info_hat = sinal_det > limiar;
n_erro = sum(xor(info,info_hat)) #para ver se os sinais conferem
taxa_erro = n_erro/n_bits

subplot(211)
plot(sinal_tx)
ylim([-0.2 1.2])
xlim([0 10*N])
subplot(212)
plot(sinal_rx)
ylim([-0.2 1.2])
xlim([0 10*N])