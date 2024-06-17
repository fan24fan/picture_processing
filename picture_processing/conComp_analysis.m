function [p_image,cwidth] =conComp_analysis(bwimg)

[x, y] = size(bwimg);
whole=x * y;
cwidth = [];
connComp = bwconncomp(bwimg); % Find connected components
threefeature = regionprops(connComp,'Area','BoundingBox','Centroid'  );
broder = [threefeature.BoundingBox];%[x y width height]�ַ�������
area = [threefeature.Area];%�������

%% ROI�ֱ�ע

for i = 1 : connComp.NumObjects  
    leftx = broder((i-1)*4+1);
    lefty = broder((i-1)*4+2);
    width = broder((i-1)*4+3);
    height = broder((i-1)*4+4);

   
    if area(i) < 80 || area(i) > 0.3 * whole  %�˳���������
      bwimg(connComp.PixelIdxList{i}) = 0;
    elseif width/height <= 0.1 || width/height > 2
      bwimg(connComp.PixelIdxList{i}) = 0;
    elseif (leftx < 100) || (leftx+width > y - 100) || (lefty < 100) || (lefty + height > x - 100) %̫������Ե��
      bwimg(connComp.PixelIdxList{i}) = 0;
    elseif width/height <= 0.11 && width * height > 20000  %��������������Σ������Ӱ������и��Ҳ���������Ϣ
      bwimg(connComp.PixelIdxList{i}) = 0;
    else
      cwidth = [cwidth,width];
      %rectangle('Position',[leftx,lefty,width,height], 'EdgeColor','g');
    end
end
p_image = bwimg;