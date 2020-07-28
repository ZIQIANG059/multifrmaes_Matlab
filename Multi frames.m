%  MULTIPLEFRAMES_V62
%
%  Only one row allowed in this program
clc;
close all;
clear all;
%%%%%%
vidObj = VideoReader('62_100 play fps.Avi');
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'));
k = 1;
while hasFrame(vidObj)
    data(k).cdata = readFrame(vidObj);
    k = k+1;
end
%  List of the frames to use
% % % 
frames_list = [252 597 1491 2089 2563 3490];
%  Total number of frames
NN = size( frames_list );  N_frames = NN(2);
s = size(frames_list);
%
%  Top right corner of image frame subsection to use
xzero = 212*ones(1,s(2),'uint16');%x location from left side
yzero = 1;%y location from top side

%  Image area from each frame
dx = 218*ones(1,s(2),'uint16'); %%distance in x direction
dy = 336; %%distance in y direction.

%  Spacing between panels in combined image
deltax = 5;
%  Size of the margin
imargine = 5;
%  Size of the resulting image
sumx = 2 * imargine;
for i=1:N_frames
    sumx = sumx + dx(i) + deltax;
end
sizex = sumx;
sizey = dy + 2 * imargine;
   
%  Initialize image to background
   imagenew(1:sizey,1:sizex) = 255;
   startx = imargine;
   for it=1:N_frames
       iframe = frames_list(it);
       temp1 = data(iframe).cdata;
       for ix=xzero(it):xzero(it)+dx(it)
         for iy=yzero:yzero+dy
           imagenew(imargine+iy-yzero,startx+ix-xzero(it)) = temp1(iy,ix);
         end
       end
     startx = startx + dx(it) + deltax;
   end
   ximage = uint8( imagenew );
   imshow(ximage);
   
   frame_rate = 75*1000;%5M
   time = (( frames_list -frames_list(1))/frame_rate)*1000.  %  ms 
   
   imwrite(ximage,'62_r1.png');