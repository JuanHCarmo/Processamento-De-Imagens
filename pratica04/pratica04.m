pkg load image;

% 1. Carregar a imagem de entrada (306x306 pixels)
entrada = imread("pratica4.jpg");
imagem1 = im2double(entrada);

% 2. Filtro de Média 9x9
filtro_media = ones(9, 9) / 81;

% Passo 5: Aplicar filtro com padding padrão (zeros)
% Resposta: A borda fica escura pois o filtro acessa valores 0 fora da imagem.
img_media_zeros = filter2(filtro_media, imagem1, "same");
imwrite(img_media_zeros, "resultado_media_zeros.jpg");

% Passo 7: Aplicar filtro com padding por replicação
% padsize 4 para um filtro 9x9
imagem_padded_media = padarray(imagem1, [4 4], "replicate", "both");
img_media_repl = filter2(filtro_media, imagem_padded_media, "valid");
imwrite(img_media_repl, "resultado_media_replicado.jpg");

% Passo 8 e 9: Filtros de Sobel
hx = [-1 0 1; -2 0 2; -1 0 1]; % Horizontal
hy = [-1 -2 -1; 0 0 0; 1 2 1];  % Vertical

% Padding para filtro 3x3 (padsize 1)
img_padded_sobel = padarray(imagem1, [1 1], "replicate", "both");

gx = filter2(hx, img_padded_sobel, "valid");
gy = filter2(hy, img_padded_sobel, "valid");

% Passo 10: Magnitude do gradiente M(x,y) = |gx| + |gy|
imagem5 = abs(gx) + abs(gy);
imwrite(imagem5, "resultado_sobel.jpg");

printf("Processamento concluido! Verifique os arquivos JPG na pasta.\n");