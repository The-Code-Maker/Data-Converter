function [k,c] = scalegetor()
[filename,pathname]=uigetfile({'*.jpg';'*bmp';'*gif'},'选择原图片');
imdata = imread([pathname,filename]);
imshow(imdata)
disp(['图片像素为: ',num2str(size(imdata,1)),'×',num2str(size(imdata,2))])
disp('依次选择图上两特征点, 完成后回车')
[x,y] = ginput();
for n = 1:size(x,1)
   disp(['第',num2str(n),'个点的像素坐标为: (',num2str(x(n)),', ',num2str(y(n)),')']) 
end

prompt={'输入真实物理长度:'};
name='输入变量范围';
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