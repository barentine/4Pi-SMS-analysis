% for v14 iPALMast_analysisv14scmos.m

function [ims qds cocrops]=iPALM_readdcimg(filename,center,co_cropims)
% July 25th 2014 updated with cocroping such that another images file with
% a similar size could be added as the third input to be cropped at the
% same area and method as the ims files.

% July 16th 2014 default position [299 464 1571 1736];

% default center position for quadrant July9th_2014 h_centers=[320 478 1556
% 1715];



files=dir(filename);
if numel(files)>1
    error('Multiple files with the same assigned name are detected');
elseif numel(files)==0
    error('No file detected');
end


[tmp totalframes]= dcimgmatlab(0, filename);
% totalframes=20000;
% ims=zeros(size(tmp,1),size(tmp,2),totalframes);
ims=single(zeros(size(tmp,2),size(tmp,1),totalframes));

cutflag=0;
cocropflag=0;

qds=[];
cocrops=[];
if nargin>1
    cutflag=1;
end

if nargin>2
    cocropflag=1;
end

if cutflag==0
    for ii=1:1:totalframes
        ims(:,:,ii)=single(dcimgmatlab(ii-1, filename))';
    end
else
    for ii=1:1:totalframes
        ims(:,:,ii)=single(dcimgmatlab(ii-1, filename))';
%         ims(:,:,ii)=dcimgmatlab(ii-1, filename);
    end
    
    flipsigns=[0 0 1 1];
    [qds]=single(iPALMscmos_makeqds(ims,center,flipsigns));
    ims=[];
    %     qd1=ims(:,(center(1)-84):(center(1)+83),:);
    %     qd2=ims(:,(center(2)-84):(center(2)+83),:);
    %     qd3=ims(:,(center(3)-84):(center(3)+83),:);
    %     qd4=ims(:,(center(4)-84):(center(4)+83),:);
    %     qd3=flipdim(qd3,2);
    %     qd4=flipdim(qd4,2);
    
    if cocropflag==1
        [cocrops]=single(iPALMscmos_makeqds(co_cropims,center,flipsigns));
        %crop all attached images
    end
    
end

clear mex



