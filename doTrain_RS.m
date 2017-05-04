function [ param,P ] = doTrain_RS( D,param )
% doTrain_RS 
%  �� doTrain Ψһ�������ڣ�����������ķ�ʽ����ල����

D = D';

[M,N] = size(D);

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
    
    
%     disp(['��',num2str(i),'�����ѭ����P��ɣ�Ŀǰ����ʱ�䣺',num2str(toc)]);
    U = updateU(D,U,V,P,params);
    
    fr2U = norm(U, 'fro');
    if isnan(fr2U)
       disp('U ---- NaN');
    end

%     disp(['��',num2str(i),'�����ѭ����U��ɣ�Ŀǰ����ʱ�䣺',num2str(toc)]);
    V = updateV_RS(D,U,V,P,params);
    
    fr2V = norm(V, 'fro');
    if isnan(fr2V)
       disp('V ---- NaN');
    end


    

    fr = norm(D-U*V, 'fro');
    loss = 1.0 / sqrt(M*N) * fr;
    result.loss=[result.loss,loss];
    

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

