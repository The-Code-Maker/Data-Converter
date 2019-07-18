function [] = img2gif(imgpath,imgname,gifname,delay)
%IMG2GIF ������ͼƬƴ�ӳ�GIF��ͼ
%   ����˵��:
%       IMG2GIF(imgpath,imgname,gifname,delay)
%
%   ��������: ������ͼƬƴ�ӳ�GIF��ͼ
%
%   ����˵��:
%       �������:
%           imgpath: ͼƬ·��
%           imgname: ����ͼƬ������
%               ȡֵΪ�ַ���Ԫ������, ��{'img-1.jpg';'img-2.jpg';'img-3.jpg'}
%           gifname: �����GIFͼƬ����
%           delay: GIF����֡ͼƬ֮���ʱ���ӳ�, ֡��=1/ʱ���ӳ�
%       �������:
%           ��
%
%   ����: �ų���
%   ʱ��: 2019��7��11��

%%
%%
switch nargin
    case 0
        imgpath = uigetdir('��ѡ����ͼƬ���ļ���');
        if isequal(imgpath,0)
            disp('! δѡ���ļ���, �����˳�...')
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
                %�����޺�׺�ļ�
                continue
            else
                %��ȡ��׺
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
            disp('! ָ���ļ����²���ͼƬ, �����˳�...')
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
                %�����޺�׺�ļ�
                continue
            else
                %��ȡ��׺
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
            disp('! ָ���ļ����²���ͼƬ, �����˳�...')
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
%-------------------------------------������--------------------------------------%
%ѭ������gif
for n = 1:length(imgname)
    %��ȡͼƬ
    im = imread(fullfile(imgpath,filesep,imgname{n}));
    if size(im,3) == 1
        tmp(:,:,1) = im;
        tmp(:,:,2) = im;
        tmp(:,:,3) = im;
        im = tmp;
    end
    [I,map] = rgb2ind(im,256);
    %д��gif
    if exist(gifname,'file')
        imwrite(I,map,gifname,'gif','WriteMode','append','DelayTime',delay)
    else
        imwrite(I,map,gifname,'gif','LoopCount',inf,'DelayTime',delay)
    end
end
%��ʾ���ɵ�gif
winopen(gifname)
end