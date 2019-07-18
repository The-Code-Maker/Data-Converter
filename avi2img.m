function [] = avi2img(avipath,aviname,imgprefix,options)
%AVI2IMG ��ȡ��Ƶ�еĶ�֡ͼƬ
%   ����˵��:
%       AVI2IMG(avipath,aviname,imgprefix,options)
%
%   ��������: ��ȡ��Ƶ�еĶ�֡ͼƬ
%
%   ����˵��:
%       �������:
%           avipath: ��Ƶ·��
%           aviname: ��Ƶ����
%           imgprefix: ����Ķ���ͼƬ��ͳһǰ׺
%           options: ��������ѡ��
%           options.skip: ��֡����
%               ��������, Ĭ��Ϊ1, ������֡
%           options.splice: ָ���Ƿ񽫶���ͼ��ƴ��
%               'on': ƴ��; 'off': ��ƴ��; Ĭ��Ϊ'on'
%           options.rodeg: ͼ����ת�Ƕ�
%               ����������, Ĭ��Ϊ0, ������ת
%           options.cut: ͼ��ü�
%               һ����������, ָ��ͼƬ�������ҵĲü�����
%               Ĭ��Ϊ[0,0,0,0], �����ü�
%       �������:
%           ��
%
%   ����: �ų���
%   ʱ��: 2019��7��11��

%%
switch nargin
    case 0
        [aviname, avipath] = uigetfile({'*.avi;*.mp4'}, 'ѡ��һ����Ƶ�ļ�');
        if isequal(aviname,0)
            disp('! δѡ����Ƶ�ļ�, �����˳�...')
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
        disp('! �����������, �����˳�...')
end
%%
try
    mov = VideoReader(fullfile([avipath,filesep,aviname]));
catch
    disp('! ����Ƶʧ��, �����˳�...')
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