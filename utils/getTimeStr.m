function [ curTimeStr ] = getTimeStr(  )
%GETTIMESTR Summary of this function goes here
%   ��ȡʱ���ַ���

curTimeStr = [num2str(year(now)),'-',num2str(month(now)),'-',num2str(day(now)),'-',num2str(hour(now)),'-',num2str(minute(now)),'-',num2str(floor(second(now)))];


end

