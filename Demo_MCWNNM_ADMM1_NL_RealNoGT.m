%-------------------------------------------------------------------------------------------------------------
% This is an implementation of the MCWNNM algorithm for real color image denoising.
% Author:  Jun Xu, csjunxu@comp.polyu.edu.hk
%              The Hong Kong Polytechnic University
%
% Please refer to the following paper if you use this code:
%
% @article{MCWNNM,
% 	author = {Jun Xu and Lei Zhang and David Zhang and Xiangchu Feng},
% 	title = {Multi-channel Weighted Nuclear Norm Minimization for Real Color Image Denoising},
% 	journal = {ICCV},
% 	year = {2017}
% }
%
% This is not the final version of MCWNNM, please do not distribute.
% Please see the file License.txt for the license governing this code.
%-------------------------------------------------------------------------------------------------------------

clear;
TT_Original_image_dir = 'NoiseClinicImages/';
TT_fpath = fullfile(TT_Original_image_dir, '*.png');
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

Par.method = 'MCWNNM_ADMM';
% the parameters for ADMM
Par.maxIter = 10;% the parameter K2 in the paper
Par.rho = 6;
Par.mu = 1;

% the parameter for estimating noise standard deviation
Par.lambda = 1.5; % We need tune this parameter for different real noisy images

i =4; % dog
Par.image = i;

Par.nim = double( imread(fullfile(TT_Original_image_dir, TT_im_dir(i).name)) );
Par.I = Par.nim;
Par.nlsp  =  70;                           % Initial Non-local Patch number
S = regexp(TT_im_dir(i).name, '\.', 'split');
fprintf('%s :\n', TT_im_dir(i).name);
[h, w, ch] = size(Par.I);
for c = 1:ch
    Par.nSig0(c,1) = NoiseEstimation(Par.nim(:, :, c), Par.ps);
end
fprintf('The noise levels are %2.2f, %2.2f, %2.2f. \n', Par.nSig0(1), Par.nSig0(2), Par.nSig0(3) );
[im_out, Par] = MCWNNM_ADMM1_NL_Denoising( Par.nim, Par.I, Par ); % WNNM denoisng function
im_out(im_out>255)=255;
im_out(im_out<0)=0;
imname = sprintf([Par.method '_NL_NC_Oite' num2str(Par.Iter) '_Iite' num2str(Par.maxIter) '_rho' num2str(Par.rho) '_mu' num2str(Par.mu) '_lambda' num2str(Par.lambda) '_' TT_im_dir(i).name]);
imwrite(im_out/255, imname);