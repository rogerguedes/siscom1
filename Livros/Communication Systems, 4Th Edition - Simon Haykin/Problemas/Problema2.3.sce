xdel(winsid())
clear
clc
freqBandaBase=10;
freqDeMod=10*freqBandaBase
t=linspace(0,1/freqBandaBase,10*freqDeMod);
portadora=cos(2*%pi*freqDeMod*t);
sinalBandaBase=cos(2*%pi*freqBandaBase*t)/2 +0.5;
sinalModulado=sinalBandaBase+portadora;
n=1000;
serie = zeros(1,size(t,2));
for i=1:n
    novaIteracao = ( ((-1)^(i-1))/(2*i-1) ) * cos(2*%pi*freqDeMod*t*(2*i-1));
    serie=serie+novaIteracao;
    gT=1/2 + (2/%pi)*serie;
end
sinalModulado=sinalModulado.*gT
figure();
plot(t,sinalModulado,'Yellow');
plot(t,portadora,'red');
plot(t,sinalBandaBase,'blue');
//figure();
plot(t,gT,'cyan');
xgrid;
//input("aperte enter para a proxima iteracao");
//close
