clear; clc;

%% ��ȡROI
[zheng, color] = tilt_corrc('.\pic\12.jpg');  %zheng�ǻҶ�ͼ��color�ǲ�ɫͼ
[ mark ] = MSERmain( zheng );  %����Ҷ�ͼ��õ����ͼ��mark�Ƕ�ֵͼ
marked = uint8(mark);
[cout, gray_cut, color_cut] = roiRowcut(marked, color);%�Ա��ͼ�Ͳ�ɫͼ����õ�ROIͼ��cout�Ǳ��ͼ��gray_cut�ǻҶ�ͼ��color_cut�ǲ�ɫͼ
[seg_num, color_seg] = roicut( cout, gray_cut, color_cut );

%% ���ղ������и�
sequ_num = 0;
sequence = {};
parfor i = 1 : seg_num
    rgb = lightcomp(color_seg{1, i});%���ղ���
    pic = mythre(rgb);%��ֵ��
    [row_num, row_cut] = rowcut(pic);%���и�
    [word_num, word_cut] = refine_wordcut(row_num, row_cut);%���и�
    [num, cut] = mser_wordcut(word_num, word_cut);%MSER�и�
    
    sequence = [sequence, cut];%�����и���
    sequ_num = sequ_num + num;%�����и�������
end

%% ƥ��ʶ��
[ shape_num, shaped ] = myshape( sequ_num, sequence );%��ȡ����
matched = GISTmatch( shape_num, shaped );%ƥ��
ean_checked = codecheck(matched);%����Ƿ�ΪEAN��

if ean_checked == 0 
   
end
