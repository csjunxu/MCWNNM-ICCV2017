
clear;
TT_Original_image_dir = 'C:\Users\csjunxu\Desktop\L0smoothing\';
TT_fpath = fullfile(TT_Original_image_dir, 'pflower.jpg');
TT_im_dir  = dir(TT_fpath);
im_num = length(TT_im_dir);

% the parameters for denoising real images
Par.win          = 20; % Non-local patch searching window
Par.delta        = 0;   % Parameter between each iter
Par.Constant  = 2 * sqrt(2);   % Constant num for the weight vector
Par.Innerloop = 2;   % InnerLoop Num of between re-blockmatching
Par.ps            = 6;   % Patch size
Par.step         = 5;
Par.Iter          = 2;    % total iter numbers, the parameter K1 in the paper
Par.display  = true;

Par.method = 'MCWNNM';
writefilepath = 'C:/Users/csjunxu/Desktop/L0smoothing/';
% the parameters for ADMM
Par.maxIter = 10;% the parameter K2 in the paper
Par.rho = 6;
Par.mu = 1;

% the parameter for estimating noise standard deviation
for lambda = 3:1:10
    Par.lambda = lambda; % We need tune this parameter for different real noisy images
    
    i = 1;
    Par.image = i;
    
    Par.nim = double( imread(fullfile(TT_Original_image_dir, TT_im_dir(i).name)) );
    Par.I = Par.nim;
    Par.nlsp  =  70;                           % Initial Non-local Patch number
    S = regexp(TT_im_dir(i).name, '\.', 'split');
    fprintf('%s :\n', TT_im_dir(i).name);
    [h, w, ch] = size(Par.I);
    Par.nSig0 = [10 10 10];
    [im_out, Par] = MCWNNM_ADMM1_NL_Denoising( Par.nim, Par.I, Par ); % WNNM denoisng function
    im_out(im_out>255)=255;
    im_out(im_out<0)=0;
    imname = sprintf([writefilepath 'pflower_' Par.method '_NL_NC_Oite' num2str(Par.Iter) '_Iite' num2str(Par.maxIter) '_rho' num2str(Par.rho) '_mu' num2str(Par.mu) '_lambda' num2str(Par.lambda) '.png']);
    imwrite(im_out/255, imname);
end