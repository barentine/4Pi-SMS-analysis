% for v14 iPALMast_analysisv14scmos.m

function [shift1 shift2]=drift_correction_corev2(im1,im2,iniguess)
corrim=single(gaussf(normxcorr2(im1,im2),1));
% corrim1=rot90(double(CrossCorrelation(im1,im2)),2);
% corrim_norm=double(gaussf(normxcorr2(im1,im1),0));
% scaleim=corrim-corrim_norm;
% scaleim(~(scaleim<1e37&scaleim>-1e37))=0;

if nargin>=3
    shift_col=iniguess(2);
    shift_row=iniguess(1);
    rowval=shift_row+(size(corrim,1)+1)./2;
    colval=shift_col+(size(corrim,2)+1)./2;
    cropsz2=32;
%     cropsz2=min(32,(colval-1)*2); 
    ori=[colval-cropsz2/2-1 rowval-cropsz2/2-1];
    smallim=cut(corrim,cropsz2,ori);
    [tmpval,rowval2,colval2]=findmax(double(smallim));
%     [rowval2, colval2]=GaussianFit((double(smallim))); 
    colval=ori(1)+colval2;
    rowval=ori(2)+rowval2;
else
    [tmpval,rowval,colval]=findmax(double(corrim));
%     [rowval2, colval2]=GaussianFit((double(smallim)));     
end
shift_row=(rowval-(size(corrim,1)+1)./2);
shift_col=(colval-(size(corrim,2)+1)./2);
cropsz=64;   % zoom factor is cropsz/exsz2
% exsz2=512;
ori=[colval-cropsz/2-1 rowval-cropsz/2-1];
rscorrim=cut(corrim,cropsz,ori);
[rowval2, colval2]=GaussianFit((double(rscorrim)));  
shift_row1=rowval2-cropsz/2;
shift_col1=colval2-cropsz/2;
% rscorrim=ift(extend(ft(cut(corrim,cropsz,ori)),exsz2));
% exsz=128;
% cropex=cut(rscorrim,exsz);
% [tmpval,rowval,colval]=findmax(double(abs(cropex)));
% [rowval, rowval]=GaussianFit((double(abs(cropex))));    
% s2row=(rowval-(exsz/2+1))*cropsz/exsz2;
% s2col=(colval-(exsz/2+1))*cropsz/exsz2;
% shift1=shift_row+s2row;
% shift2=shift_col+s2col;
shift1=shift_row+shift_row1-1;
shift2=shift_col+shift_col1-1;