function [ I5, color ] = tilt_corrc( str )


%% ��бУ��
Pic = imread(str);
b = rgb2gray(Pic);

[row, array] = size(b);
if row < array
    B = imrotate(b, 90, 'loose');
    pic = imrotate(Pic, 90, 'loose');
else
    B = b;
    pic = Pic;
end

I2 = wiener2(B, [8, 8]); 
I3 = edge(I2, 'sobel', 'horizontal');  %��Ե��ȡ

theta = 0 : 179;
r = radon(I3, theta);  %ֱ�߼��
[m, n] = size(r); 
c = 1; 

for i = 1 : m
   for j = 1 : n
      if r(1,1) < r(i,j)
         r(1,1) = r(i,j);
         c = j;
      end
   end
end

rot_theta = 90 - c; 
I5 = imrotate(B, rot_theta, 'crop');
color = imrotate(pic, rot_theta, 'crop');