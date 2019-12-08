function [] = img2avi(imgpath,imgname,aviname)
%IMG2AVI ������ͼƬ�Ƴɶ���
%   ����˵��:
%       IMG2AVI(imgpath,imgname,gifname,delay)
%
%   ��������: ������ͼƬ�Ƴɶ���
%
%   ����˵��:
%       �������:
%           imgpath: ͼƬ·��
%           imgname: ����ͼƬ������
%               ȡֵΪ�ַ���Ԫ������, ��{'img-1.jpg';'img-2.jpg';'img-3.jpg'}
%           aviname: �������Ƶ����
%       �������:
%           ��
%
%   ����: �ų���
%   ʱ��: 2019��10��28��

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
        aviname = 'DefaultGifFileName.avi';
    case 2
        aviname = 'DefaultGifFileName.avi';
end

%%
%-------------------------------------������--------------------------------------%
%������Ƶ
avi = VideoWriter(aviname, 'Motion JPEG AVI');
open(avi);
for n = 1:length(imgname)
    %��ȡͼƬ
    im = imread(fullfile(imgpath,filesep,imgname{n}));
    writeVideo(avi,im);
end
close(avi);

end