clear; clc;

%% 提取ROI
[zheng, color] = tilt_corrc('.\pic\12.jpg');  %zheng是灰度图，color是彩色图
[ mark ] = MSERmain( zheng );  %处理灰度图像得到标记图，mark是二值图
marked = uint8(mark);
[cout, gray_cut, color_cut] = roiRowcut(marked, color);%对标记图和彩色图处理得到ROI图，cout是标记图，gray_cut是灰度图，color_cut是彩色图
[seg_num, color_seg] = roicut( cout, gray_cut, color_cut );

%% 光照补正、切割
sequ_num = 0;
sequence = {};
parfor i = 1 : seg_num
    rgb = lightcomp(color_seg{1, i});%光照补正
    pic = mythre(rgb);%二值化
    [row_num, row_cut] = rowcut(pic);%行切割
    [word_num, word_cut] = refine_wordcut(row_num, row_cut);%字切割
    [num, cut] = mser_wordcut(word_num, word_cut);%MSER切割
    
    sequence = [sequence, cut];%保存切割结果
    sequ_num = sequ_num + num;%保存切割结果数量
end

%% 匹配识别
[ shape_num, shaped ] = myshape( sequ_num, sequence );%提取特征
matched = GISTmatch( shape_num, shaped );%匹配
ean_checked = codecheck(matched);%检查是否为EAN码

if ean_checked == 0 
   
end
