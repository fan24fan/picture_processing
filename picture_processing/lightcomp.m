function [ rgb ] = lightcomp( color_seg )

[h,s,v] = rgb2hsv(color_seg); %ת��hsv�ռ䣬������v����

% ��˹�˲�
HSIZE = min(size(color_seg,1),size(color_seg,2));%��˹����˳ߴ�
q = sqrt(2);
SIGMA1 = 15; %���������c
SIGMA2 = 80;
SIGMA3 = 250;


F1 = fspecial('gaussian',HSIZE,SIGMA1/q);
F2 = fspecial('gaussian',HSIZE,SIGMA2/q) ;
F3 = fspecial('gaussian',HSIZE,SIGMA3/q) ;
gaus1 = imfilter(v, F1, 'replicate');
gaus2 = imfilter(v, F2, 'replicate');
gaus3 = imfilter(v, F3, 'replicate');
gaus = (gaus1+gaus2+gaus3)/3;    %��߶ȸ�˹�������Ȩ��Ȩ��Ϊ1/3

%��ά٤����

m = mean(gaus(:));
gama = power(0.5,((m-gaus)/m)); %���ݹ�ʽgammaУ���������Ĺ�ʽ����
out = (power(v,gama));
rgb = hsv2rgb(h,s,out);  %ת��rgb�ռ���ʾ