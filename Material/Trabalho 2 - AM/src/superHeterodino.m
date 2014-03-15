%limpando as variáveis e a tela{
clear%limpa todas as variáveis.
clc%limpa a tela.
close all%fecha todas as janelas.
%}
load('sinal_AM.mat');
subplot(2,1,1);
rf_stage(s,t,f,550000,150000);
figure();
subplot(2,1,1);
plot(t,s)