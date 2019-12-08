function [] = imgcomb(imgpath,imgl,imgr,imgname)

Il = imread(fullfile(imgpath,filesep,imgl));
Ir = imread(fullfile(imgpath,filesep,imgr));
[h,w,~] = size(Il);
I = [Il(1:h,1:floor(w/2)-1,:),Ir(1:h,floor(w/2)+1:end,:)];
imwrite(I,imgname)

end