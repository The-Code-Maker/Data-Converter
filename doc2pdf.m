function [] = doc2pdf(docpath,docname)
%DOC2PDF Microsoft Word文档(*.doc, *.docx)转为Adobe Pdf文档(*.pdf)
%   调用说明:
%       DOC2PDF
%       DOC2PDF(docpath,docname) 将文档docpath\docname转为pdf文档
%       DOC2PDF(docpath) 将该文件夹下所有的Microsoft Word文档转为pdf文档
%
%   功能描述: Microsoft Word文档(*.doc, *.docx)转为Adobe Pdf文档(*.pdf)
%
%   参数说明:
%       输入参数:
%           docpath: 视频路径
%           docname: 视频名称
%       输出参数:
%           无
%
%   其他说明: 需要安装Microsft Word 2010及以上的版本
%
%   作者: 张晨星
%   时间: 2019年7月20日

switch nargin
    case 0
        [docname,docpath] = uigetfile('*.doc;*.docx','请选择一个Microsoft Word文档');
        if isequal(docname,0)
            disp('! 未选择文档, 程序退出...')
            return
        end
        try
            %若word服务器已经打开，返回其句柄Word
            Word = actxGetRunningServer('Word.Application');
        catch
            %创建一个Microsoft Word服务器，返回句柄Word
            Word = actxserver('Word.Application');
        end
        if strcmp(docname(end-2:end),'doc')
            str = docname(1:end-4);
        elseif strcmp(docname(end-3:end),'docx')
            str = docname(1:end-5);
        end
        documents = Word.Documents.Open([docpath,'\',docname]);
        documents.SaveAs2([docpath,'\',str,'.pdf'],17)
        documents.Close()
        disp(['文档: ',docname,'成功转换为: ',str,'.pdf!'])
    case 1
        try
            %若word服务器已经打开，返回其句柄Word
            Word = actxGetRunningServer('Word.Application');
        catch
            %创建一个Microsoft Word服务器，返回句柄Word
            Word = actxserver('Word.Application');
        end
        dirinfo = dir(docpath);
        for n = 3:length(dirinfo)
            flag = 0;
            docname = dirinfo(n).name;
            if strcmp(docname(end-2:end),'doc')
                str = docname(1:end-4);
                flag = 1;
            elseif strcmp(docname(end-3:end),'docx')
                str = docname(1:end-5);
                flag = 1;
            end
            if flag
                documents = Word.Documents.Open([docpath,'\',docname]);
                documents.SaveAs2([docpath,'\',str,'.pdf'],17)
                documents.Close()
                disp(['文档: ',docname,'成功转换为: ',str,'.pdf!'])
            end
        end
        Word.Quit()
    case 2
        try
            %若word服务器已经打开，返回其句柄Word
            Word = actxGetRunningServer('Word.Application');
        catch
            %创建一个Microsoft Word服务器，返回句柄Word
            Word = actxserver('Word.Application');
        end
        if strcmp(docname(end-2:end),'doc')
            str = docname(1:end-4);
        elseif strcmp(docname(end-3:end),'docx')
            str = docname(1:end-5);
        end
        documents = Word.Documents.Open([docpath,'\',docname]);
        documents.SaveAs2([docpath,'\',str,'.pdf'],17)
        documents.Close()
        disp(['文档: ',docname,'成功转换为: ',str,'.pdf!'])
end

end