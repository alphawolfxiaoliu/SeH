function [ params ] = init( D,param )
%INIT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

if param.randomSample == 0
    params.outer_loop_num = 120;
elseif param.randomSample == 1
    params.outer_loop_num = 80;
end
params.inner_loop_num = 100;

% params.outer_loop_num = 2;
% params.inner_loop_num = 2;

[M,N]=size(D);

params.db_name = param.db_name;
% params.method = param.method;
params.sampleNum = param.sampleNum;

params.alpha = param.alpha;
params.beta = param.beta;
params.epsilon = param.epsilon;
params.mu = param.mu;
params.lambda = param.lamda;
params.gamma = param.gamma;
params.delta = param.delta;

params.K = param.nbits;
K = params.K;

% params.step = 0.01;
% params.step = 0.005; % bitλ���ϴ�ʱ����Ҫʹ�������С�Ĳ���

params.step = 0.001;
% params.step = 0.0002;
% params.step = -(5e-05) * K + 0.0074;  % ����K�仯�Ĳ���

updateV_step = params.step


% ��ʹ���������ʱ�� S
if param.randomSample == 0
    params.S = param.S;
    S = params.S; % S���󣨼���WtrueTrainTraining���Ǹ��Գ��󣬶Խ���Ԫ�ر�ȫΪ1������ʾѵ�����ڲ������Ƴ̶�
    A = zeros(N,N);
    for n = 1:N
        A(n,n) = sum(S(n,:));
    end

    L = A - S;
    params.L = L;

    O = ones(N,N) - S;
    params.O = O;
    
    params.randomSampleNum = 0; % SemiNMFH_supervised ������û�õ� randomSampleNum����������Ϊ0������Ҳû�ã�
end

% ʹ���������ʱ�� train_label
if param.randomSample == 1
    params.train_label = param.train_label;
    params.randomSampleNum = param.randomSampleNum; % ÿ��С�����Ĳ�������
end


Uinit = rand(M,K);
for n = 1:K
    Uinit(:,n) = Uinit(:,n) ./ norm(Uinit(:,n),2); % �й�һ��
end


% Vinit = rand(K,N) * 2 - 1; % ��ʼ��һ��Ԫ�ط�ΧΪ[-1,1]���������
Vinit = initV(K,N);  % ��ʼ��һ��Ԫ�ط�ΧΪ[-1,1]���������,����ÿһ�����Ϊ0

params.Uinit = Uinit;
params.Vinit = Vinit;

end

