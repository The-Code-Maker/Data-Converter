function [] = avi2img(avipath,aviname,imgprefix,options)
%AVI2IMG 提取视频中的多帧图片
%   调用说明:
%       AVI2IMG(avipath,aviname,imgprefix,options)
%
%   功能描述: 提取视频中的多帧图片
%
%   参数说明:
%       输入参数:
%           avipath: 视频路径
%           aviname: 视频名称
%           imgprefix: 输出的多张图片的统一前缀
%           options: 函数功能选择
%           options.skip: 跳帧数量
%               整型数据, 默认为1, 即不跳帧
%           options.splice: 指定是否将多张图形拼接
%               'on': 拼接; 'off': 不拼接; 默认为'on'
%           options.rodeg: 图像旋转角度
%               浮点型数据, 默认为0, 即不旋转
%           options.cut: 图像裁剪
%               一行四列数列, 指定图片上下左右的裁剪比例
%               默认为[0,0,0,0], 即不裁剪
%       输出参数:
%           无
%
%   作者: 张晨星
%   时间: 2019年7月11日

%%
switch nargin
    case 0
        [aviname, avipath] = uigetfile({'*.avi;*.mp4'}, '选择一个视频文件');
        if isequal(aviname,0)
            disp('! 未选择视频文件, 程序退出...')
            return
        end
        imgprefix = 'DefaultImgFileName-';
        options.skip = 1;
        options.splice = 'on';
        options.rodeg = 0;
        options.cut = [0,0,0,0];
    case 2
        imgprefix = 'DefaultImgFileName-';
        options.skip = 1;
        options.splice = 'on';
        options.rodeg = 0;
        options.cut = [0,0,0,0];
    case 3
        options.skip = 1;
        options.splice = 'on';
        options.rodeg = 0;
        options.cut = [0,0,0,0];
    case 4
        allfields = {'skip';'splice';'rodeg';'cut'};
        fieldsvalue = {1;'on';0;[0,0,0,0]};
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
end
%%
try
    mov = VideoReader(fullfile([avipath,filesep,aviname]));
catch
    disp('! 打开视频失败, 程序退出...')
end
counter = 1;
while 1
    try
        im = readFrame(mov);
        imh = size(im,1);
        imw = size(im,2);
        imhup = ceil(imh*options.cut(1))+1;
        imhdown = imh - ceil(imh*options.cut(2));
        imwleft = ceil(imw*options.cut(3))+1;
        imwright = imw - ceil(imw*options.cut(4));
        im = im(imhup:imhdown,imwleft:imwright,:);
        im = imrotate(im,options.rodeg);
        imgname = [imgprefix,num2str(counter),'.jpg'];
        imwrite(im,imgname,'jpg')
        switch options.splice
            case 'on'
                if isequal(counter,1)
                    imgspl = im;
                else
                    if isequal(mod(counter,options.skip),0)
                        imgspl(:,end+1:end+size(im,2),:) = im;
                    end
                end
        end
        counter = counter + 1;
    catch
        break
    end
end
imgname =  [imgprefix,'splice.jpg'];
imwrite(imgspl,imgname,'jpg')

end