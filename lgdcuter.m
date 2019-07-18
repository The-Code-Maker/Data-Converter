function [] = lgdcuter(imgpath,imgname)
%LGDCUTER 图例裁剪程序

%%
switch nargin
    case 0
        [imgname,imgpath] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg;*.JPG;*.PNG;*.BMP;*.JPEG'}, '选择一张图片');
        if isequal(imgpath,0)
            disp('! 未选择图片, 程序退出...')
            return
        end
    case 2
        
    otherwise
        disp('! 输入参数错误, 程序退出...')
        return
end
if ~exist(fullfile(imgpath,filesep,imgname),'file')
    disp('! 图片不存在, 程序退出...')
    return
end

%%
imdata = imread(fullfile(imgpath,filesep,imgname));
imdata = imdata(:,:,1);
rowmin = 1;
colmin = 1;
rowmax = 1;
colmax = 1;
for n = 1:size(imdata,1)
    index = find(imdata(n,:) < 100);
    if ~isempty(index)
        colmin = index(1);
        colmax = index(end);
        break
    end
end
for m = 1:size(imdata,2)
    index = find(imdata(:,m) < 100);
    if ~isempty(index)
        rowmin = index(1);
        rowmax = index(end);
        break
    end
end
imdata = imread(fullfile(imgpath,filesep,imgname));
imdata = imdata(rowmin:rowmax,colmin:colmax,:);
imwrite(imdata,[imgname(1:end-4),'-Cut',imgname(end-3:end)])
end