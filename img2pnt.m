function [x,y] = img2pnt(imgpath,imgname,options)
%IMG2PNT 提取纯黑背景中的亮点坐标
%   调用说明:
%       [x,y] = IMG2PNT(imgpath,imgname)
%
%   功能描述: 提取纯黑背景中的亮点坐标
%
%   参数说明:
%       输入参数:
%           imgpath: 图片路径
%           imgname: 图片名称
%           options: 函数相关功能
%           options.scale: 图片坐标按比例放大
%               'on': 放大功能开启;'off': 放大功能关闭; 默认为'off';
%           options.lenx: 横向最大真实尺寸
%               浮点数类型, 在放大功能开启时有效, 默认为1
%           options.leny: 竖向最大真实尺寸
%               浮点数类型, 在放大功能开启时有效, 默认为1
%               横向和竖向比例不一致时, 取横向比例缩放
%       输出参数:
%           x: 横坐标
%           y: 纵坐标
%
%   作者: 张晨星
%   时间: 2019年7月14日

%%
switch nargin
    case 0
        [imgname,imgpath] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg;*.JPG;*.PNG;*.BMP;*.JPEG'}, '选择一张图片');
        if isequal(imgpath,0)
            disp('! 未选择图片, 程序退出...')
            x = 0; y = 0;
            return
        end
        options.scale = 'off';
        options.lenx = 1;
        options.leny = 1;
    case 2
        options.scale = 'off';
        options.lenx = 1;
        options.leny = 1;
    case 3
        allfields = {'scale';'lenx';'leny'};
        fieldsvalue = {'on';1;1};
        fields = fieldnames(options);
        for k = 1:length(allfields)
            flag = 1;
            for l = 1:length(fields)
                if strcmp(allfields{k},fields{l})
                    flag = 0;
                end
            end
            if flag
                options.(allfields{k}) = fieldsvalue{k};
            end
        end
        
    otherwise
        disp('! 输入参数错误, 程序退出...')
        x = 0; y = 0;
        return
end
if ~exist(fullfile(imgpath,filesep,imgname),'file')
    disp('! 图片不存在, 程序退出...')
    x = 0; y = 0;
    return
end

%%
%读取图形信息
imdata = imread(fullfile(imgpath,filesep,imgname));
imdata = double(imdata(:,:,1));

%去除背景 获取轮廓像素点
labels = zeros(1,3);
counter = 1;
for n = 1:size(imdata,1)
    for m = 1:size(imdata,2)
        if imdata(n,m) > 200
            labels(counter,1) = m;
            labels(counter,2) = n;
            labels(counter,3) = 0;
            counter = counter + 1;
        end
    end
end

%缩放至真实尺寸
x_min = min(labels(:,1));
x_max = max(labels(:,1));
y_min = min(labels(:,2));
y_max = max(labels(:,2));

coefy = options.leny/(y_max - y_min);
coefx = options.lenx/(x_max - x_min);
if ~isequal(coefx,coefy)
    coefy = coefx;
end
labels = labels*(coefx+coefy)/2;
[labels(:,1),index] = sort(labels(:,1));
labels(:,2) = labels(index,2);
labels(:,1) = labels(:,1) - max(labels(:,1));
labels(:,2) = max(labels(:,2)) - labels(:,2);
x = labels(:,1);
y = labels(:,2);

end
