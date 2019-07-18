function [x,y] = img2pnt(imgpath,imgname,options)
%IMG2PNT ��ȡ���ڱ����е���������
%   ����˵��:
%       [x,y] = IMG2PNT(imgpath,imgname)
%
%   ��������: ��ȡ���ڱ����е���������
%
%   ����˵��:
%       �������:
%           imgpath: ͼƬ·��
%           imgname: ͼƬ����
%           options: ������ع���
%           options.scale: ͼƬ���갴�����Ŵ�
%               'on': �Ŵ��ܿ���;'off': �Ŵ��ܹر�; Ĭ��Ϊ'off';
%           options.lenx: ���������ʵ�ߴ�
%               ����������, �ڷŴ��ܿ���ʱ��Ч, Ĭ��Ϊ1
%           options.leny: ���������ʵ�ߴ�
%               ����������, �ڷŴ��ܿ���ʱ��Ч, Ĭ��Ϊ1
%               ��������������һ��ʱ, ȡ�����������
%       �������:
%           x: ������
%           y: ������
%
%   ����: �ų���
%   ʱ��: 2019��7��14��

%%
switch nargin
    case 0
        [imgname,imgpath] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg;*.JPG;*.PNG;*.BMP;*.JPEG'}, 'ѡ��һ��ͼƬ');
        if isequal(imgpath,0)
            disp('! δѡ��ͼƬ, �����˳�...')
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
        disp('! �����������, �����˳�...')
        x = 0; y = 0;
        return
end
if ~exist(fullfile(imgpath,filesep,imgname),'file')
    disp('! ͼƬ������, �����˳�...')
    x = 0; y = 0;
    return
end

%%
%��ȡͼ����Ϣ
imdata = imread(fullfile(imgpath,filesep,imgname));
imdata = double(imdata(:,:,1));

%ȥ������ ��ȡ�������ص�
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

%��������ʵ�ߴ�
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
