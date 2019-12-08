function [] = img2avi(imgpath,imgname,aviname)
%IMG2AVI 将多张图片制成动画
%   调用说明:
%       IMG2AVI(imgpath,imgname,gifname,delay)
%
%   功能描述: 将多张图片制成动画
%
%   参数说明:
%       输入参数:
%           imgpath: 图片路径
%           imgname: 多张图片的名称
%               取值为字符串元胞数据, 如{'img-1.jpg';'img-2.jpg';'img-3.jpg'}
%           aviname: 输出的视频名称
%       输出参数:
%           无
%
%   作者: 张晨星
%   时间: 2019年10月28日

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
        aviname = 'DefaultGifFileName.avi';
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
        aviname = 'DefaultGifFileName.avi';
    case 2
        aviname = 'DefaultGifFileName.avi';
end

%%
%-------------------------------------主程序--------------------------------------%
%生成视频
avi = VideoWriter(aviname, 'Motion JPEG AVI');
open(avi);
for n = 1:length(imgname)
    %读取图片
    im = imread(fullfile(imgpath,filesep,imgname{n}));
    writeVideo(avi,im);
end
close(avi);

end