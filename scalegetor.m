function [k,c] = scalegetor()
[filename,pathname]=uigetfile({'*.jpg';'*bmp';'*gif'},'ѡ��ԭͼƬ');
imdata = imread([pathname,filename]);
imshow(imdata)
disp(['ͼƬ����Ϊ: ',num2str(size(imdata,1)),'��',num2str(size(imdata,2))])
disp('����ѡ��ͼ����������, ��ɺ�س�')
[x,y] = ginput();
for n = 1:size(x,1)
   disp(['��',num2str(n),'�������������Ϊ: (',num2str(x(n)),', ',num2str(y(n)),')']) 
end

prompt={'������ʵ������:'};
name='���������Χ';
numlines=1;
defaultanswer={'1'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer=inputdlg(prompt,name,numlines,defaultanswer,options);
rl = str2double(answer);
pl = x(2) - x(1);
k = rl/pl;
c = [(x(2) + x(1))/2,(y(2) + y(1))/2];
end