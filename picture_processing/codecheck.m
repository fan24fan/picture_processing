function [checked] = codecheck(matched)

load('.\data\category.mat');
str1 = [num2str(690), num2str(691), num2str(692), num2str(693), num2str(694), num2str(695), num2str(696)];
str2 = reshape(str2num(str1'),[],7)';

checked = 0;
for i = 1 : 7 
    start = strfind(matched, str2(i, :));  %ȷ��������ֵ������ʼλ��
    if ~isempty(start)
        ean = matched(1, start : start + 12);  %��⵽����Ʒ����
        
        for j = 1 : kind_num
            check_flag = strfind(ean, devide(j, :));  %��Ʒ����ȷ��
            if ~isempty(check_flag)
                checked = j;
                break;
            end
        end
        
        break;
    end
end


if checked ~= 0  %ȷ��������Ҫʶ��ͼƬ����Ʒ������
    following = checked;
    save('.\data\following.mat', 'following');
end
