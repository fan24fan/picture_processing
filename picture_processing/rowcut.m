function [ cout, line_cut ] = rowcut( B )


[X,Y] = find(B == 1);
edge_cut = B(min(X): max(X), min(Y): max(Y));  %�޳���Χ��Ŀհ�

[m, ~] = size(edge_cut);  %Ѱ���м�հ�
countY = 256 * ones(m,1);  %������һ�к����һ��
for i = 1 : m-2  
  if isempty(find(edge_cut(i+1, :),1))
      countY(i+1, 1) = countY(i, 1) + 1;  %�����ֵĿհ������б����Ϊ256
  else
      countY(i+1, 1) = 255;  %���ֲ��ֱ���Ϊ255
  end
end

[white_mark, ~] = find(countY == 256);  %���з�
cout = size(white_mark) - 1;
line_cut = {cout};
for j = 1 : cout
    row = edge_cut(white_mark(j):white_mark(j+1), :);
    [X1,~] = find(row == 1);
    line_cut{j} = row(min(X1): max(X1), :);  %�����м�ڱ�
end




