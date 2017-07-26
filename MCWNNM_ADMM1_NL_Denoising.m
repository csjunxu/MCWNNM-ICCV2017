function [E_Img, Par]   =  MCWNNM_ADMM1_NL_Denoising( N_Img, O_Img, Par )
E_Img           = N_Img;   % Estimated Image
[h, w, ch]  = size(E_Img);
Par.h = h;
Par.w = w;
Par.ch = ch;
Par = SearchNeighborIndex( Par );
% noisy image to patch
NoiPat =	Image2Patch( N_Img, Par );
Par.TolN = size(NoiPat, 2);
Sigma = ones(Par.ch, length(Par.SelfIndex));
for iter = 1 : Par.Iter
    Par.iter = iter;
    % iterative regularization
    E_Img =	E_Img + Par.delta * (N_Img - E_Img);
    % image to patch
    CurPat =	Image2Patch( E_Img, Par );
    % estimate local noise variance
    for c = 1:Par.ch
        if(iter == 1)
            TempSigma_arrCh = Par.lambda * Par.nSig0(c) * Sigma(c, :);
        else
            TempSigma_arrCh = Par.lambda * Sigma(c, :);
        end
        Sigma_arrCh((c-1)*Par.ps2+1:c*Par.ps2, :) = repmat(TempSigma_arrCh, [Par.ps2, 1]);
    end
    
    if (mod(iter-1, Par.Innerloop) == 0)
        Par.nlsp = Par.nlsp - 10;  % Lower Noise level, less NL patches
        NL_mat  =  Block_Matching_Real(CurPat, Par);% Caculate Non-local similar patches for each
    end
    [Y_hat, W_hat, Sigma]  =  MCWNNM_ADMM1_NL_Estimation( NL_mat, Sigma_arrCh, NoiPat, Par );   % Estimate all the patches
    E_Img = PGs2Image(Y_hat, W_hat, Par);
    %%
    PSNR  = csnr( O_Img, E_Img, 0, 0 );
    SSIM      =  cal_ssim( O_Img, E_Img, 0, 0 );
    fprintf( 'Iter = %2.3f, PSNR = %2.2f, SSIM = %2.2f \n', iter, PSNR, SSIM );
    Par.PSNR(iter, Par.image)  =   PSNR;
    Par.SSIM(iter, Par.image)      =  SSIM;
end
return;





