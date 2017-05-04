function [ db_data, db_label ] = loadData( db_name, sampleNum )
% ���� ���� �� ��ǩ
% db_name�����ݼ�����
% sampleNum��ѡȡ����������
% evalMethod�����۷�ʽ


% % Ϊ�˼����ļ�����������ǰ�������ڵ�Ŀ¼���ĺ�������֮�������������ȥ��
% p1 = mfilename('fullpath');
% i=findstr(p1,'\');
% p1=p1(1:i(end));
% cd(p1);
% cd('..')
% 
% % addpath('../');
% addpath('..');

% load dataset
load cnn_1024d_Caltech-256.mat;
db_datalabel = feat;
db_data = db_datalabel(1:sampleNum, 1:end);

rgbImgList = rgbImgList(1:sampleNum);
[dataNum,~] = size(rgbImgList);
db_label = zeros(dataNum,1);
for i = 1:dataNum
    strcell = rgbImgList(i,1);
    str = strcell{1};
    db_label(i,1) = str2num(str(1:3));
end



db_data = db_data(1:sampleNum,:);
db_label = db_label(1:sampleNum,:);

db_data_size = size(db_data)
db_label_size = size(db_label)

disp('���ݼ������...');




end

