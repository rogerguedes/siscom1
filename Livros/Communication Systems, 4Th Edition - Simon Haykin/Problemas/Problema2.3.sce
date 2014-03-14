xdel(winsid())
clear
clc
maxFreqBandaBase=10;//Hz
freqDeMod=10*maxFreqBandaBase//Hz
freqDeAmostragem = 20*freqDeMod;//sempre maior que 2X, Teorema de Nyquist
tempoDeAmostragem = 1/maxFreqBandaBase;
t=linspace(0,tempoDeAmostragem,((1/maxFreqBandaBase)/(1/freqDeMod))*((1/freqDeMod)/(1/freqDeAmostragem))+1);//segundos
portadora=cos(2*%pi*freqDeMod*t);
sinalBandaBase=cos(2*%pi*maxFreqBandaBase*t)/2 +0.5;
sinalModulado=sinalBandaBase+portadora;
n=1000;
serie = zeros(1,size(t,2));
for i=1:n
    novaIteracao = ( ((-1)^(i-1))/(2*i-1) ) * cos(2*%pi*freqDeMod*t*(2*i-1));
    serie=serie+novaIteracao;
    gT=1/2 + (2/%pi)*serie;
end
sinalModulado=sinalModulado.*gT;
figure();
subplot(2,1,1)
plot(t,sinalModulado,'Yellow');
plot(t,portadora,'red');
plot(t,sinalBandaBase,'blue');
plot(t,gT,'cyan');
xgrid;
fftDoSinalModulado=fft(sinalModulado);
modFftDoSinalModulado=abs(fftDoSinalModulado);
eixoEmFreq = linspace(0,freqDeAmostragem/2, (size(modFftDoSinalModulado,2)/2) )
subplot(2,1,2);
plot(eixoEmFreq, (modFftDoSinalModulado(1:floor(size(fftDoSinalModulado,2)/2))) / (size(fftDoSinalModulado,2)/2));
