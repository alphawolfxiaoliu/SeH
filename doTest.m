function [ B ] = doTest( testSet,P,param )
%DOTEST �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

D = testSet';

% [M,N] = size(D);

V = P * D;

V = p1(V); % ��ֵ��
V = (V>0);
V = V';

% B = compactbit(V);
B = (V);

end

