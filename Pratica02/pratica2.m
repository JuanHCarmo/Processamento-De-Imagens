pkg load image;

inImage = imread("pollen.jpg");

[lin, col] = size(inImage);
img_out = zeros(lin, col, 'uint8');

r1 = 90; s1 = 0;
r2 = 140; s2 = 255;

T = zeros(1, 256);
T = uint8(T);

for r = 0:255
  if r < r1
    m = (s1 - 0) / (r1 - 0);
    T(r +1) = 0 + m * (r - 0);
  elseif r <= r2
    m = (s2 - s1) / (r2 - r1);
    T(r +1) = s1 + m * (r - r1);
  else
    m = (255 - s2) / (255 - r2);
    T(r + 1) = s2 + m * (r - r2);
  end

end

figure;
plot(0:255, T);
title('Função de Transformação T(r)');
xlabel('Intensidade de Entrada (r)');
ylabel('Intensidade de Saida (s)');
grid on;

img_out = T(double(inImage) + 1);

figure;
subplot(1,2,1);
imshow(inImage);
title('Imagem Original');
subplot(1,2,2);
imshow(img_out);
imwrite(img_out, 'pollen_melhorado.jpg');
pause;