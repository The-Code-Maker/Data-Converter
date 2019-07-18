function [] = img2dat(imgpath,imgname,datname)
%IMG2DAT ��ͼƬ�еĵ�����д��dat�ļ�
%   ����˵��:
%       IMG2DAT(imgpath,imgname,datname)
%
%   ��������: ��ͼƬ�еĵ�����д��dat�ļ�
%
%   ����˵��:
%       �������:
%           imgpath: ͼƬ·��
%           imgname: ͼƬ����
%           datname: dat�ļ�����
%       �������:
%           ��
%
%   ����: �ų���
%   ʱ��: 2019��7��11��

%%
if nargin == 0
    [imgname,imgpath] = uigetfile({'*.*'},'ѡ��һ��ͼƬ�ļ�');
    if isequal(imgname,0)
        disp('! δѡ��ͼƬ, �����˳�...')
        return
    end
    datname = imgname(1:end-4);
elseif nargin ~= 3
    disp('! �����������, �����˳�...')
    return
end
try
    imdata = imread([imgpath,imgname]);
catch
    disp('! ��ȡͼƬ����, �����˳�...')
    return
end
imshow(imdata)

disp('����ѡ��ͼ������ԭ���(x�����, y�����)��, ��ɺ�س�')
[x0,y0] = ginput();
disp('ѡ��ͼƬ�ϴ��������ĵ�, ��ɺ�س�')
[x,y] = ginput();
%��һ��
x1 = (x-min(x0))/(max(x0)-min(x0));
y1 = (y-max(y0))/(min(y0)-max(y0));
%���ٻ�
prompt={'����x��Сֵ:','����x���ֵ:','����y��Сֵ:','����y���ֵ:'};
name='���������Χ';
numlines=1;
defaultanswer={'0','1','0','1'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer=inputdlg(prompt,name,numlines,defaultanswer,options);
xrange = [str2double(answer(1)),str2double(answer(2))];
yrange = [str2double(answer(3)),str2double(answer(4))];
x2 = x1*(xrange(2)-xrange(1)) + xrange(1);
y2 = y1*(yrange(2)-yrange(1)) + yrange(1);
figure
plot(x2,y2)
var2dat([imgpath,datname],[x2,y2])
end