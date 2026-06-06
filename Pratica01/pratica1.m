pkg load image

% Leitura das imagens
img = imread('tungsten_filament_shaded.tif');
shading = imread('tungsten_sensor_shading.tif');

% Conversão para double
img = im2double(img);
shading = im2double(shading);

% Evitar divisão por zero
shading(shading == 0) = 0.01;

% Correção de sombreamento
img_corrigida = img ./ shading;

% Normalização
img_corrigida = img_corrigida - min(img_corrigida(:));
img_corrigida = img_corrigida / max(img_corrigida(:));

% Exibição
figure; imshow(img); title('Imagem Original');
figure; imshow(img_corrigida); title('Imagem Corrigida');

% Salvamento
imwrite(img_corrigida, 'resultado_corrigido.tif');
