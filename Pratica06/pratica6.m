pkg load image;

clc;
clear;
close all;

% =========================
% Leitura da imagem
% =========================
I = im2double(imread('pratica7.png'));

if size(I,3) == 3
    I = rgb2gray(I);
end

[M,N] = size(I);

% =========================
% Transformada de Fourier
% =========================
F = fft2(I);
Fs = fftshift(F);

% =========================
% Espectro
% =========================
espectro = log(1 + abs(Fs));
espectro = mat2gray(espectro);

imwrite(espectro, 'espectro.png');

% =========================
% Criação do filtro Notch + Gaussiano suavizado
% =========================
H = ones(M,N);

cx = floor(M/2)+1;
cy = floor(N/2)+1;

espessura     = 15;
sigma         = 8;
janela_centro = 40;

% Aplica atenuação gaussiana na faixa horizontal
for i = 1:M
    dist = abs(i - cx);
    if dist <= espessura + 25
        fator = 1 - exp(-(dist^2) / (2 * sigma^2));
        H(i, :) = fator;
    end
end

% Preserva janela central intacta (componente DC e estrutura global)
H(cx-janela_centro:cx+janela_centro, cy-janela_centro:cy+janela_centro) = 1;

imwrite(mat2gray(H), 'filtro.png');

% =========================
% Aplicação do filtro
% =========================
G = Fs .* H;

% =========================
% Transformada inversa
% =========================
resultado = real(ifft2(ifftshift(G)));
resultado = mat2gray(resultado);

imwrite(resultado, 'resultado.png');

% =========================
% Exibição das Imagens
% =========================
figure;

subplot(2,2,1);
imshow(I);
title('Original');

subplot(2,2,2);
imshow(espectro);
title('Espectro de Fourier');

subplot(2,2,3);
imagesc(H); colormap gray; axis image off;
title('Filtro Notch Gaussiano');

subplot(2,2,4);
imshow(resultado);
title('Resultado Sem Ruido');

fprintf('Pressione qualquer tecla para fechar...\n');
pause;