function [] = var2dat(filename,variable)
%VAR2DAT ��MATLAB����д��dat�ļ�
%   ����˵��:
%       VAR2DAT(filename,variable)
%
%   ��������: ��MATLAB����д��dat�ļ�
%
%   ����˵��:
%       �������:
%           filename: dat�ļ���(����.dat��׺)
%           variable: ����(������������, ���������߾���)
%       �������:
%           ��
%
%   ����: �ų���
%   ʱ��: 2019��7��11��

%%
if nargin == 1
    variable = filename;
    filename = 'DefaultDatFileName';
elseif nargin == 0 || nargin > 2
    error('������������')
end

[row,col] = size(variable);
for n = 1:row
    fid = fopen([filename,'.dat'],'a');
    for m = 1:col-1
        fprintf(fid,'%f ',variable(n,m));
    end
    fprintf(fid,'%f\n',variable(n,col));
    fclose(fid);
end

end