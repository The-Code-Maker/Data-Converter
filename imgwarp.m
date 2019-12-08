function [] = imgwarp(imgpath,imgname,method)

switch nargin
    case 0
        [imgname,imgpath] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg;*.JPG;*.PNG;*.BMP;*.JPEG'}, 'ѡ��һ��ͼƬ');
        if isequal(imgpath,0)
            disp('! δѡ��ͼƬ, �����˳�...')
            return
        end
        method = 'v';
    case 2
        method = 'v';
    case 3
        
    otherwise
        disp('! �����������, �����˳�...')
        return
end
if ~exist(fullfile(imgpath,filesep,imgname),'file')
    disp('! ͼƬ������, �����˳�...')
    return
end

I = imread(fullfile(imgpath,filesep,imgname));
[Height,Width]=size(I);                 %��ȡԭͼ��ĸ߶ȺͿ��
switch method
    case 'h'
        T=affine2d([-1 0 0;0 1 0;Width 0 1]);  %����ռ�任�ṹT������Ϊˮƽ����任����
    case 'v'
        T=affine2d([1 0 0;0 -1 0;0 Height 1]); %����ռ�任�ṹT������Ϊ��ֱ����任����
end

A=imwarp(I,T);                        %��ԭͼ��I���о���任
imwrite(A,[imgname(1:end-4),'-',method,'-Warp',imgname(end-3:end)])


end