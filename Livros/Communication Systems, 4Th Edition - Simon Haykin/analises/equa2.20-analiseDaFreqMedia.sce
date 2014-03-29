xdel(winsid())
clear
clc
freqDeAmostragem = 10000;
TdeAmostragem = 1/freqDeAmostragem;
freqS1 = 20;
Ts1 = 1/freqS1;
t=[0:TdeAmostragem:Ts1];//um periodo do sinal 01
freqS2=((2*freqS1)/Ts1).*t;//freqS2 variando de uma forma que seu valor médio é igual à freqS1 dentro do periodo correspondente a freqS1;
s1=cos(2*%pi*freqS1.*t);
s2=cos(2*%pi*freqS2.*t);
subplot(1,2,1)
plot(t,freqS1)
plot(t,freqS2,'red')//até aqui tudo bem...
xgrid
subplot(1,2,2)
plot(t,s1)
plot(t,s2,'red')//mas ao plotar o sinal com frequência  variável, ele executou 2 períodos do sinal com frequência constante...
xgrid
