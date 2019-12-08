function [] = imgwarp(imgpath,imgname,method)

switch nargin
    case 0
        [imgname,imgpath] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg;*.JPG;*.PNG;*.BMP;*.JPEG'}, '选择一张图片');
        if isequal(imgpath,0)
            disp('! 未选择图片, 程序退出...')
            return
        end
        method = 'v';
    case 2
        method = 'v';
    case 3
        
    otherwise
        disp('! 输入参数错误, 程序退出...')
        return
end
if ~exist(fullfile(imgpath,filesep,imgname),'file')
    disp('! 图片不存在, 程序退出...')
    return
end

I = imread(fullfile(imgpath,filesep,imgname));
[Height,Width]=size(I);                 %获取原图像的高度和宽度
switch method
    case 'h'
        T=affine2d([-1 0 0;0 1 0;Width 0 1]);  %构造空间变换结构T，这里为水平镜像变换矩阵
    case 'v'
        T=affine2d([1 0 0;0 -1 0;0 Height 1]); %构造空间变换结构T，这里为竖直镜像变换矩阵
end

A=imwarp(I,T);                        %对原图像I进行镜像变换
imwrite(A,[imgname(1:end-4),'-',method,'-Warp',imgname(end-3:end)])


end