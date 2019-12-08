function [] = imgcon(imgpath,imgname,newimgname,options)
%Í¼Æ¬Æ´½Ó
for n = 1:size(imgname,1)
    if isequal(n,1)
        im = imread(fullfile(imgpath,filesep,imgname{n}));
        imh = size(im,1);
        imw = size(im,2);
        imhup = ceil(imh*options.cut(1))+1;
        imhdown = imh - ceil(imh*options.cut(2));
        imwleft = ceil(imw*options.cut(3))+1;
        imwright = imw - ceil(imw*options.cut(4));
        im = im(imhup:imhdown,imwleft:imwright,:);
        im = imrotate(im,options.rodeg);
        imspl = im;
    else
        im = imread(fullfile(imgpath,filesep,imgname{n}));
        imh = size(im,1);
        imw = size(im,2);
        imhup = ceil(imh*options.cut(1))+1;
        imhdown = imh - ceil(imh*options.cut(2));
        imwleft = ceil(imw*options.cut(3))+1;
        imwright = imw - ceil(imw*options.cut(4));
        im = im(imhup:imhdown,imwleft:imwright,:);
        im = imrotate(im,options.rodeg);
        imspl(:,end+1:end+size(im,2),:) = im;
    end
end
imwrite(imspl,[imgpath,filesep,newimgname]);

end