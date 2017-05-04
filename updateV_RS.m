function [ V ] = updateV_RS( D,U,V_pre,P,params )
% U,P fixed, seek V
%  �� updateV Ψһ�������ڣ�����������ķ�ʽ����ල����

[M,N] = size(D);
[M,K] = size(U);

V = V_pre;

inner_loop_num = params.inner_loop_num; % �ڲ��������
alpha = params.alpha;
beta = params.beta;
epsilon = params.epsilon;
mu = params.mu;
lambda = params.lambda;
gamma = params.gamma;
step = params.step; % ����
% L = params.L; % ѵ����������ͬ�����
% O = params.O; % ѵ�����������������

randomSampleNum = params.randomSampleNum; % ÿ��С�������������ʱȡ������������

A = U' * U;
B = U' * D;
C = P * D;

train_label = params.train_label;


RS_index_whole = randperm(N);
cursor = 1; % ��ʾ��������� RS_index_whole �ĵڼ�����


for i = 1:inner_loop_num
    
    G_lambda = zeros(K,N);
    for k = 1:K
        raw_sum = 0;
        for n = 1:N
            raw_sum = V(k,n) + raw_sum;
        end
        if raw_sum > 0 
            G_lambda(k,:) = zeros(1,N) + 1;
        else
            G_lambda(k,:) = zeros(1,N) - 1;
        end
    end

    G_gamma = zeros(K,N);
    for k = 1:K
        for n = 1:N
            if V(k,n) >= 0 
                G_gamma(k,n) = 2 * (V(k,n) - 1);
            else
                G_gamma(k,n) = 2 * (V(k,n) + 1);
            end
        end
    end
    
    
   % RS_index_whole ֻ��ÿ�δ�ѭ�����һ�Σ�Ȼ����ÿ��Сѭ���RS_index ����ȡ RS_index_whole ��ֵ
    theEnd = (cursor + randomSampleNum -1);
    if theEnd>N
        theEnd = mod(theEnd,N);
        RS_index = [RS_index_whole(cursor:N),RS_index_whole(1:theEnd)];
    else
        RS_index = RS_index_whole(cursor:theEnd);
    end
    cursor = theEnd + 1;

    
%     RS_index = randperm(N,sampleNum);
    
    
    R = getEleMatrix(RS_index,N); % �������ʱ����ת���ĳ��Ⱦ��� ���� R ��ˣ��� R' �ҳˣ�
    V0 = V(:,RS_index); % V0 �Ǿ������������� V ��ʵ���ϣ�V0 = V * R'��
    
    RS_label = train_label(RS_index,:);
    
    S = simMatByLabel(RS_label,RS_label);
    
    AA = zeros(randomSampleNum,randomSampleNum);
    for n = 1:randomSampleNum
        AA(n,n) = sum(S(n,:));
    end
    
    L = AA - S;
    
    O = 1 - S;
    
%     gradient = (2*A*V-2*B) + lambda*G_lambda + gamma*G_gamma + epsilon*2*(V-C) + mu*alpha*2*V0*L*R + mu*beta*2*V0*O*R;
    gradient = (2*A*V-2*B) + lambda*G_lambda + gamma*G_gamma + epsilon*2*(V-C) + mu*V0*(alpha*2*L + beta*2*O)*R;
    
%     % ����ڲ�ѭ�������
%     fr2V = norm(V, 'fro');
%     fr = norm(D-U*V, 'fro');
%     loss = 1.0 / sqrt(M*N) * fr;
%     disp(['��',num2str(i),'���ڲ�ѭ����ɣ� loss = ',num2str(loss),'  fr2V = ',num2str(fr2V)]);
    
    V = V - step * gradient;
    
end  









end

