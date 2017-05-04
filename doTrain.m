function [ param,P ] = doTrain( D,param )
%DOTRAIN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

D = D';

[M,N] = size(D);

% fr2D = norm(D, 'fro')


params = init(D,param);

outer_loop_num = params.outer_loop_num;

result.iter=[];
result.loss=[];
result.time=[];

U = params.Uinit;
V = params.Vinit;

% tic;
for i = 1:outer_loop_num
    
    
    
    P = updateP(D,V,params);
    
    fr2P = norm(P, 'fro');
    if isnan(fr2P)
       disp('P ---- NaN');
    end
    
    U = updateU(D,U,V,P,params);
    
    
    fr2U = norm(U, 'fro');
    if isnan(fr2U)
       disp('U ---- NaN');
    end

%     disp(['��',num2str(i),'�����ѭ����U��ɣ�Ŀǰ����ʱ�䣺',num2str(toc)]);
    V = updateV(D,U,V,P,params);
    
    fr2V = norm(V, 'fro');
    if isnan(fr2V)
       disp('V ---- NaN');
    end


    % record results
    result.iter=[result.iter,i];
    fr = norm(D-U*V, 'fro');
    loss = 1.0 / sqrt(M*N) * fr;
    result.loss=[result.loss,loss];
    
    disp(['iter ', num2str(i), ':  loss = ', num2str(loss)]);
    
    % ������ NaN ����ֹͣ
    if isnan(loss)
       break;
    end
    
end












V = p1(V); % ��ֵ��
V = (V>0);
V = V';
param.V = V;

% param.B = compactbit(V);
param.B = (V);




end

