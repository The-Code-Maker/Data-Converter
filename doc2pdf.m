function [] = doc2pdf(docpath,docname)
%DOC2PDF Microsoft Word�ĵ�(*.doc, *.docx)תΪAdobe Pdf�ĵ�(*.pdf)
%   ����˵��:
%       DOC2PDF
%       DOC2PDF(docpath,docname) ���ĵ�docpath\docnameתΪpdf�ĵ�
%       DOC2PDF(docpath) �����ļ��������е�Microsoft Word�ĵ�תΪpdf�ĵ�
%
%   ��������: Microsoft Word�ĵ�(*.doc, *.docx)תΪAdobe Pdf�ĵ�(*.pdf)
%
%   ����˵��:
%       �������:
%           docpath: ��Ƶ·��
%           docname: ��Ƶ����
%       �������:
%           ��
%
%   ����˵��: ��Ҫ��װMicrosft Word 2010�����ϵİ汾
%
%   ����: �ų���
%   ʱ��: 2019��7��20��

switch nargin
    case 0
        [docname,docpath] = uigetfile('*.doc;*.docx','��ѡ��һ��Microsoft Word�ĵ�');
        if isequal(docname,0)
            disp('! δѡ���ĵ�, �����˳�...')
            return
        end
        try
            %��word�������Ѿ��򿪣���������Word
            Word = actxGetRunningServer('Word.Application');
        catch
            %����һ��Microsoft Word�����������ؾ��Word
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
        disp(['�ĵ�: ',docname,'�ɹ�ת��Ϊ: ',str,'.pdf!'])
    case 1
        try
            %��word�������Ѿ��򿪣���������Word
            Word = actxGetRunningServer('Word.Application');
        catch
            %����һ��Microsoft Word�����������ؾ��Word
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
                disp(['�ĵ�: ',docname,'�ɹ�ת��Ϊ: ',str,'.pdf!'])
            end
        end
        Word.Quit()
    case 2
        try
            %��word�������Ѿ��򿪣���������Word
            Word = actxGetRunningServer('Word.Application');
        catch
            %����һ��Microsoft Word�����������ؾ��Word
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
        disp(['�ĵ�: ',docname,'�ɹ�ת��Ϊ: ',str,'.pdf!'])
end

end