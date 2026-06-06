pkg load image; % [cite: 11]

clear;
clc;
close all;

% 1. Ler a imagem
% (Nota: O roteiro cita 'pratica6.png' por engano, mas o arquivo fornecido é 'pratica5.png')
img = imread('pratica5.png');

% 2. Converter para double
img = im2double(img); % [cite: 13]

% Dimensões da imagem original
[M, N] = size(img);

% 3. Zero padding
P = 2 * M;
Q = 2 * N;

% 4. Transformada Rápida de Fourier 2D
F = fft2(img, P, Q); % [cite: 15]

% RESPOSTA PASSO 4:
% A dimensão da transformada é: P x Q = 512 x 512 [cite: 16]

% 5. Centralizar a transformada
F_shift = fftshift(F); % [cite: 18]

% 6. Mostrar espectro de Fourier
espectro = log(1 + abs(F_shift)); % [cite: 19, 20]

% Normalização para garantir o brilho do espectro na escala de 0 a 255
espectro_norm = (espectro - min(espectro(:))) / (max(espectro(:)) - min(espectro(:))) * 255;

figure;
imshow(uint8(espectro_norm)); % Convertido para uint8 conforme o passo 6 [cite: 20]
title('Espectro de Fourier');

% 7. Construir filtro passa-baixa gaussiano
D0 = 20; % [cite: 21]

H = zeros(P, Q);

for u = 1:P
    for v = 1:Q

        D = sqrt((u - P/2)^2 + (v - Q/2)^2); % [cite: 23]

        H(u,v) = exp(-(D^2) / (2 * (D0^2))); % [cite: 22]

    end
end

% Mostrar filtro gaussiano
figure;
imshow(mat2gray(H));
title('Filtro Passa-Baixa Gaussiano');

% 8. Multiplicação elemento por elemento
G = F_shift .* H; % [cite: 24, 25]

% 9. Descentralizar
G_shift = ifftshift(G); % [cite: 27]

% 10. Transformada inversa de Fourier
g = ifft2(G_shift); % [cite: 28]

% 11. Selecionar somente a parte real
g_real = real(g); % [cite: 29]

% 12. Extrair região original M x N (Canto superior esquerdo)
resultado = g_real(1:M, 1:N); % [cite: 30]

% --- CORREÇÃO PARA A ÚLTIMA IMAGEM APARECER ---
% Corta qualquer resíduo numérico para garantir o intervalo exato [0, 1]
resultado(resultado < 0) = 0;
resultado(resultado > 1) = 1;

% 13. Mostrar resultado final
figure;
imshow(im2uint8(resultado)); % Convertido para im2uint8 conforme o passo 13 [cite: 32]
title('Resultado Final');
