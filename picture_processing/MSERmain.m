function [ ROI ] = MSERmain( grayImage )

%% mser������ȡ
mserRegions = detectMSERFeatures(grayImage);
mserRegionsPixels = vertcat(cell2mat(mserRegions.PixelList));

%% ��mser���������ϵ��ȡ������Ȼ����Ӧϵ���ĵط���ֵΪ�档ȡ��mser����
mserMask = false(size(grayImage));
ind = sub2ind(size(mserMask), mserRegionsPixels(:,2), mserRegionsPixels(:,1));
mserMask(ind) = true;

%% ��ͨ�����
[p_image,cwidth] = conComp_analysis(mserMask);
figure;imshow(grayImage);
wi= median(cwidth(:))/2;
se1=strel('line',wi,0);
p_image_dilate= imclose(p_image,se1);

%% ϸ�˳�
[ROI] = f_conComp_analysis(p_image_dilate,grayImage);
