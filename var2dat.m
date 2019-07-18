function [] = var2dat(filename,variable)
%VAR2DAT 将MATLAB变量写入dat文件
%   调用说明:
%       VAR2DAT(filename,variable)
%
%   功能描述: 将MATLAB变量写入dat文件
%
%   参数说明:
%       输入参数:
%           filename: dat文件名(不含.dat后缀)
%           variable: 变量(可以是行向量, 列向量或者矩阵)
%       输出参数:
%           无
%
%   作者: 张晨星
%   时间: 2019年7月11日

%%
if nargin == 1
    variable = filename;
    filename = 'DefaultDatFileName';
elseif nargin == 0 || nargin > 2
    error('参数个数错误！')
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