RD = imread('reddot.jpg');
close all
set(groot,'defaultLineLineWidth',2)
scrsz = get(0, 'ScreenSize')
imshow(RD)
set(gcf, 'Position', [scrsz(3) scrsz(4) scrsz(3)/5 scrsz(4)/5]);
hold on

