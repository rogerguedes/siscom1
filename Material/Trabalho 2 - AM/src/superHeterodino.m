%limpando as variaveis e a tela{
    clear%limpa todas as variaveis.
    clc%limpa a tela.
    close all%fecha todas as janelas.
%}

%carrega o arquivo dos sinais modulados{
    load('sinal_AM.mat');%carrega o arquivo fornecido pelo professor.
    freqDeAmostragem = 1/Ts;%Ts eh o periodo de amostragem do sinal 's' fornecido pelo professor. Para facilitar a implementacão do modulador, criei essa variavel 'freqDeAmostragem'.
%}

%obtencao da estacao desejada modulada na frequencia intermediraria{
    sinalEmFreqIntermediaria = rf_stage(s,t,f,550000,150000);%obtem a estacao de 150kHz modulada em uma frequencia intermediaria de 550kHz.
%}

% plotando o sinal da estacao desejada modulada na frequencia intermediraria{
    figure();%cria uma nova janela de plotagem de graficos.
    subplot(2,2,1);%divide a janela grafica em 4 espacos e usa o 1o espaco.
    hold on;%forca um grafico ser plotado em cima do outro.
    plot(t,sinalEmFreqIntermediaria);%plota o sinal apos passar pelo sintonizador
    xlabel('Tempo (s)');%coloca a legenda do grafico.
    grid;%liga as linhas de grade do grafico.
%}

% obtendo a FFT da estacao desejada modulada na frequencia intermediraria{
    fftSinalEmFreqIntermediaria = fft(sinalEmFreqIntermediaria);%obtem a FFT do sinal em frequencia intermediaria.
    modFftSinalEmFreqIntermediaria = abs(fftSinalEmFreqIntermediaria);%obtem o modulo da FFT do sinal em frequencia intermediaria.
%}

% plotando a FFT da estacao desejada modulada na frequencia intermediraria{
    eixoEmFreq=linspace(0,freqDeAmostragem/2, (size(fftSinalEmFreqIntermediaria,2)/2) );% gera o eixo de frequencias para exibicão da FFT
    subplot(2,2,2)%divide a janela grafica em 4 espacos e usa o 2o espaco
    hold on;%forca um grafico ser plotado em cima do outro.
    plot(eixoEmFreq,(modFftSinalEmFreqIntermediaria(1:floor(size(fftSinalEmFreqIntermediaria,2)/2))) / (size(fftSinalEmFreqIntermediaria,2)/2));% plota a FFT da estacao desejada modulada na frequencia intermediraria
    xlabel('Frequencia (Hz)');%coloca a legenda do grafico.
    grid;%liga as linhas de grade do grafico.
%}

% criar o filtro Passa Banda para filtrar a estacao desejada modulada na frequencia intermediraria{
    corteInferiorDoFiltro1 = 540000/freq_max;%obtendo o indice inferior de corte do filtro (varia de 0 a 1, onde 1 é a maior frequencia possivel)
    corteSuperiorDoFiltro1 = 560000/freq_max;%obtendo o indice superior de corte do filtro (varia de 0 a 1, onde 1 é a maior frequência possivel)
    [numeradorDoFiltro1,denominadorDofiltro1] = butter(4,[corteInferiorDoFiltro1, corteSuperiorDoFiltro1]); %filtro Passa Banda entre 540kHz e 560kHz.
%}

% plotando a resposta em frequencia do filtro Passa Faixa{
    [respostaEmFreqDoFiltro1,w]=freqz(numeradorDoFiltro1,denominadorDofiltro1,size(eixoEmFreq,2),freqDeAmostragem);%obtendo a resposta em frequencia do filtro
    picoDoSpectro=max((modFftSinalEmFreqIntermediaria(1:floor(size(sinalEmFreqIntermediaria,2)/2))) / (size(sinalEmFreqIntermediaria,2)/2));%calcula o maximo valor da FFT do sinal filtrado para plotar a Resposta do Filtro sobre o mesmo grafico da FFT do sinal de entrada. Apenas para questao de visualizacao.
    hold on;%forca um grafico ser plotado em cima do outro.
    plot(eixoEmFreq, abs(respostaEmFreqDoFiltro1)*picoDoSpectro,'magenta')%plotando a resposta em frequencia em cima da FFT de sinal em frequencia intermediaria.
%}

%filtrando o sinal modulado para envia-lo ao segundo estagio de modulacao{
    sinalEmFreqIntermediaria_Filtrado = filter(numeradorDoFiltro1,denominadorDofiltro1,sinalEmFreqIntermediaria);
%}

% plotando o sinal da estacao desejada modulada na frequencia intermediraria apos a filtragem para entrar no amplificador{
    subplot(2,2,3);%divide a janela grafica em 4 espacos e usa o 1o espaco.
    plot(t,sinalEmFreqIntermediaria,'black');%plota o sinal apos passar pelo sintonizador
    hold on
    plot(t,sinalEmFreqIntermediaria_Filtrado,'red');%plota o sinal apos passar pelo sintonizador
    xlabel('Tempo (s)');%coloca a legenda do grafico.
    grid;%liga as linhas de grade do grafico.
%}

% obtendo a FFT da estacao desejada modulada na frequencia intermediraria{
    fftSinalEmFreqIntermediaria_Filtrado = fft(sinalEmFreqIntermediaria_Filtrado);%obtem a FFT do sinal em frequencia intermediaria.
    modfFtSinalEmFreqIntermediaria_Filtrado = abs(fftSinalEmFreqIntermediaria_Filtrado);%obtem o modulo da FFT do sinal em frequencia intermediaria.
%}

% plotando a FFT da estacao desejada modulada na frequencia intermediraria apos a filtragem para entrar no amplificador{
    subplot(2,2,4)%divide a janela grafica em 4 espacos e usa o 2o espaco
    hold on;%forca um grafico ser plotado em cima do outro.
    plot(eixoEmFreq,(modfFtSinalEmFreqIntermediaria_Filtrado(1:floor(size(fftSinalEmFreqIntermediaria_Filtrado,2)/2))) / (size(fftSinalEmFreqIntermediaria_Filtrado,2)/2),'red');% plota a FFT da estacao desejada modulada na frequencia intermediraria
    xlabel('Frequencia (Hz)');%coloca a legenda do grafico.
    grid;%liga as linhas de grade do grafico.
%}

% plotando a resposta em frequencia do filtro Passa Faixa{
    hold on;%forca um grafico ser plotado em cima do outro.
    plot(eixoEmFreq, abs(respostaEmFreqDoFiltro1)*picoDoSpectro,'blue')%plotando a resposta em frequencia em cima da FFT de sinal em frequencia intermediaria apos a filtragem para entrar no amplificador.
%}

% teste CAG

    temanhoDaJanelaDoCAG = 10;
    ganhoDoCAG=1;

    freq = 550000;
    tempo=[0:(1/freq)/10:10*(1/freq)];
  
    % gerando sinais para teste{
        sinalNormal = cos(2*pi*freq*tempo);
        sinalAtenuado = exp(-tempo*100000).*cos(2*pi*freq*tempo);
        sinalTotal = [sinalNormal sinalAtenuado];
    %}
    
    %plotando sinais de teste{
        figure()
        subplot(3,1,1)
        plot(sinalNormal,'red');
        hold on
        plot(sinalAtenuado,'green');
        hold on
        tempoTotal=[0:(1/freq)/10:2*10*(1/freq)+(1/freq/10)];
        subplot(3,1,2);
        plot(sinalTotal,'blue');
        grid
    %}
    
    
    
    %restauracao{
    sinalRestaurado = sinalTotal(1,1:temanhoDaJanelaDoCAG);

    rmsDesejado = 32;
    rmsInical = rms(sinalAtenuado(1:temanhoDaJanelaDoCAG))
    for j = temanhoDaJanelaDoCAG+1 : size(sinalTotal,2)
        sinalRestaurado(j) = sinalTotal(j)*ganhoDoCAG;
        rmsAtual = rms(sinalTotal(j-temanhoDaJanelaDoCAG:j));
        ganhoDoCAG = rmsDesejado/rmsAtual;
    end
    %}
    
    %plotando sinal restaurado
    subplot(3,1,3);
    plot(sinalRestaurado,'red');
    grid
    %}

%}