function [] = img2dat(imgpath,imgname,datname)
%IMG2DAT 将图片中的点坐标写入dat文件
%   调用说明:
%       IMG2DAT(imgpath,imgname,datname)
%
%   功能描述: 将图片中的点坐标写入dat文件
%
%   参数说明:
%       输入参数:
%           imgpath: 图片路径
%           imgname: 图片名称
%           datname: dat文件名称
%       输出参数:
%           无
%
%   作者: 张晨星
%   时间: 2019年7月11日

%%
if nargin == 0
    [imgname,imgpath] = uigetfile({'*.*'},'选择一个图片文件');
    if isequal(imgname,0)
        disp('! 未选择图片, 程序退出...')
        return
    end
    datname = imgname(1:end-4);
elseif nargin ~= 3
    disp('! 输入参数错误, 程序退出...')
    return
end
try
    imdata = imread([imgpath,imgname]);
catch
    disp('! 读取图片错误, 程序退出...')
    return
end
imshow(imdata)

disp('依次选择图上坐标原点和(x轴最大, y轴最大)点, 完成后回车')
[x0,y0] = ginput();
disp('选择图片上待输出坐标的点, 完成后回车')
[x,y] = ginput();
%归一化
x1 = (x-min(x0))/(max(x0)-min(x0));
y1 = (y-max(y0))/(min(y0)-max(y0));
%量纲化
prompt={'输入x最小值:','输入x最大值:','输入y最小值:','输入y最大值:'};
name='输入变量范围';
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