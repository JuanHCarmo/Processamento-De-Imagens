pkg load image;

% 1. Carregar a imagem
img = imread('imagem.jpg');

% Se a imagem for RGB, converter para escala de cinza
if ndims(img) == 3
    img = rgb2gray(img);
end

img = uint8(img);

% Parâmetros
[Lx, Ly] = size(img);
L = 256; % níveis de cinza

% 2. Calcular histograma
[counts, x] = imhist(img);

% 3. Normalizar histograma (probabilidade)
p = counts / (Lx * Ly);

% 4. Calcular função acumulada (CDF)
cdf = zeros(L,1);
cdf(1) = p(1);

for i = 2:L
    cdf(i) = cdf(i-1) + p(i);
end

% 5. Função de transformação T(r)
T = round((L-1) * cdf);

% 6. Aplicar transformação na imagem
img_eq = zeros(Lx, Ly);

for i = 1:Lx
    for j = 1:Ly
        intensidade = img(i,j) + 1; % índice começa em 1
        img_eq(i,j) = T(intensidade);
    end
end

img_eq = uint8(img_eq);

% 7. Plotar T(r)
figure;
plot(0:L-1, T);
title('Função de Transformação T(r)');
xlabel('Intensidade original (r)');
ylabel('Intensidade transformada');
axis([0 255 0 255]);

% 8. Mostrar imagens
figure;
subplot(1,2,1);
imshow(img);
title('Imagem Original');

subplot(1,2,2);
imshow(img_eq);
title('Imagem Equalizada');

% 9. Salvar imagem
imwrite(img_eq, 'imagem_equalizada.jpg');



