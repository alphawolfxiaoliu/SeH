function [ R ] = initV( K,N, min,max )
% ��ʼ������ V ��Ҫ�� V ��ÿһ���������ӵ���0
% Ҫ��Ԫ�صľ���ֵ��СΪ min ,���Ϊ max 

% disp('initV');

% K = 5;
% N = 6;
min = 0.8;
max = 1;

n = floor(N/2);
% r = rand(K,n) * (max - min) + min; % ��ʼ��һ��Ԫ�ط�ΧΪ[-1,1]��������󣬶���Ԫ����СΪmin�����Ϊmax
r = rand(K,n); % ��ʼ��һ��Ԫ�ط�ΧΪ[0,1]���������

R = r;
if mod(N,2) ~= 0 % N������
    R = [R,zeros(K,1)];
end
R = [R,-r];
for k = 1:K
    R(k,:) = R(k,randperm(N)); % ��R��ÿһ�ж�����˳��
end
clear k;
clear r;
clear n;

% R

end

