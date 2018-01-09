clc;clear;

imdbPath = 'data/33case/imdb.mat';
cropimagesPath = 'data/33cases_MICCAI2009/CropDCMImages_33case';
croplabelsPath = 'data/33cases_MICCAI2009/CropSegmentationClass_33case';

imdb = load(imdbPath) ;
colormap=zeros(3,3);
colormap(2,1)=1;
colormap(3,3)=1;
size = find(imdb.images.segmentation) ;

for i = 1:numel(size)
    %create croped images
    if i < 1508
        imagePath = sprintf(imdb.paths.image2, imdb.images.name{i}) ;
        I = load(imagePath);
        picture = I.picture;
        picture = imcrop(picture,[64,64,127,127]);
%         filename = fullfile(cropimagesPath,[imdb.images.name{i} '.mat']);
        save(fullfile(cropimagesPath,[imdb.images.name{i} '.mat']),'picture');
    else
        imagePath = sprintf(imdb.paths.image, imdb.images.name{i}) ;
        I = dicomread(imagePath);
        t = imcrop(I,[64,64,127,127]);
        dicomwrite(t,fullfile(cropimagesPath,[imdb.images.name{i} '.dcm']));
    end    
    %create croped labels
    labelsPath = sprintf(imdb.paths.classSegmentation, imdb.images.name{i}) ;
    I2 = imread(labelsPath);
    t2 = imcrop(I2,[64,64,127,127]);
    imwrite(t2,colormap,fullfile(croplabelsPath,[imdb.images.name{i} '.png']));
end