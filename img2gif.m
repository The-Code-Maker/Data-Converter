function [] = img2gif(imgpath,imgname,gifname,delay)
%IMG2GIF 将多张图片拼接成GIF动图
%   调用说明:
%       IMG2GIF(imgpath,imgname,gifname,delay)
%
%   功能描述: 将多张图片拼接成GIF动图
%
%   参数说明:
%       输入参数:
%           imgpath: 图片路径
%           imgname: 多张图片的名称
%               取值为字符串元胞数据, 如{'img-1.jpg';'img-2.jpg';'img-3.jpg'}
%           gifname: 输出的GIF图片名称
%           delay: GIF中两帧图片之间的时间延迟, 帧率=1/时间延迟
%       输出参数:
%           无
%
%   作者: 张晨星
%   时间: 2019年7月11日

%%
%%
switch nargin
    case 0
        imgpath = uigetdir('请选择存放图片的文件夹');
        if isequal(imgpath,0)
            disp('! 未选择文件夹, 程序退出...')
            return
        end
        pathinfo = dir(imgpath);
        imgname = {};
        counter = 1;
        imgsuffix = {'jpg';'bmp';'png';'jpeg';...
            'JPG';'BMP';'PNG';'JPEG'};
        for n = 3:length(pathinfo)
            pos = regexp(pathinfo(n).name,'\.');
            if isempty(pos)
                %跳过无后缀文件
                continue
            else
                %获取后缀
                suffix = pathinfo(n).name(pos(end)+1:end);
                for m = 1:length(imgsuffix)
                    if strcmp(suffix,imgsuffix{m})
                        imgname{counter} = pathinfo(n).name;
                        counter = counter + 1;
                        break
                    end
                end
            end
        end
        if counter == 1
            disp('! 指定文件夹下不含图片, 程序退出...')
            return
        end
        gifname = 'DefaultGifFileName.gif';
        delay = 0.02;
    case 1
        pathinfo = dir(imgpath);
        imgname = {};
        counter = 1;
        imgsuffix = {'jpg';'bmp';'png';'jpeg';...
            'JPG';'BMP';'PNG';'JPEG'};
        for n = 3:length(pathinfo)
            pos = regexp(pathinfo(n).name,'\.');
            if isempty(pos)
                %跳过无后缀文件
                continue
            else
                %获取后缀
                suffix = pathinfo(n).name(pos(end)+1:end);
                for m = 1:length(imgsuffix)
                    if strcmp(suffix,imgsuffix{m})
                        imgname{counter} = pathinfo(n).name;
                        counter = counter + 1;
                        break
                    end
                end
            end
        end
        if counter == 1
            disp('! 指定文件夹下不含图片, 程序退出...')
            return
        end
        gifname = 'DefaultGifFileName.gif';
        delay = 0.02;
    case 2
        gifname = 'DefaultGifFileName.gif';
        delay = 0.02;
    case 3
        delay = 0.02;
end

%%
%-------------------------------------主程序--------------------------------------%
%循环生成gif
for n = 1:length(imgname)
    %读取图片
    im = imread(fullfile(imgpath,filesep,imgname{n}));
    if size(im,3) == 1
        tmp(:,:,1) = im;
        tmp(:,:,2) = im;
        tmp(:,:,3) = im;
        im = tmp;
    end
    [I,map] = rgb2ind(im,256);
    %写入gif
    if exist(gifname,'file')
        imwrite(I,map,gifname,'gif','WriteMode','append','DelayTime',delay)
    else
        imwrite(I,map,gifname,'gif','LoopCount',inf,'DelayTime',delay)
    end
end
%显示生成的gif
winopen(gifname)
end