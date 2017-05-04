function [ V ] = updateV( D,U,V_pre,P,params )
% U,P fixed, seek V
%   �˴���ʾ��ϸ˵��

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
L = params.L; % ѵ����������ͬ�����
O = params.O; % ѵ�����������������

A = U' * U;
B = U' * D;
C = P * D;




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
    
    gradient = (2*A*V-2*B) + lambda*G_lambda + gamma*G_gamma + epsilon*2*(V-C) + mu*alpha*2*V*L + mu*beta*2*V*O;
    
%     % ����ڲ�ѭ�������
%     fr2V = norm(V, 'fro');
%     fr = norm(D-U*V, 'fro');
%     loss = 1.0 / sqrt(M*N) * fr;
%     disp(['��',num2str(i),'���ڲ�ѭ����ɣ� loss = ',num2str(loss),'  fr2V = ',num2str(fr2V)]);
    
    V = V - step * gradient;
    
end









end

