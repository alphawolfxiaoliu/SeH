function [ eleMatrix ] = getEleMatrix( index, N )
%GETELEMATRIX ����һ�����Ⱦ���
%   index ��һ��������
% ����index = [1,2,4]��N = 6����
%     eleMatrix = 
%     [[1,0,0,0,0,0]
%      [0,1,0,0,0,0]
%      [0,0,0,1,0,0]]

[~,r] = size(index);
eleMatrix = zeros(r,N);
for i = 1:r
    eleMatrix(i,index(i)) = 1;
end


end

