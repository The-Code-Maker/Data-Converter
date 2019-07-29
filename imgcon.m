function [] = imgcon(imgpath,imgname)

for n = 1:size(imgname,1)
    if isequal(n,1)
        im = imread(fullfile(imgpath,filesep,imgname{n}));
        imspl = im;
    else
        im = imread(fullfile(imgpath,filesep,imgname{n}));
        imspl(:,end+1:end+size(im,2),:) = im;
    end
end
imwrite(imspl,[imgpath,filesep,'DefaultImgNameSplice.jpg']);

end