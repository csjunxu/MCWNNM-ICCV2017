function [rI, Par]   =  MCWNNM_ADMM1_Denoising( nI, I, Par )
rI           = nI;   % Estimated Image
[h, w, ch]  = size(rI);
Par.h = h;
Par.w = w;
Par.ch = ch;
Par = SearchNeighborIndex( Par );
% noisy image to patch
NoiPat =	Image2Patch( nI, Par );
Par.TolN = size(NoiPat, 2);
Sigma_arrCh = zeros(Par.ch, Par.TolN);
for iter = 1 : Par.Iter
    Par.iter = iter;
    % iterative regularization
    rI =	rI + Par.delta * (nI - rI);
    % image to patch
    CurPat =	Image2Patch( rI, Par );
    % estimate local noise variance
    for c = 1:Par.ch
        if(iter == 1)
            TempSigma_arrCh = sqrt(max(0, repmat(Par.nSig0(c)^2, 1, size(CurPat, 2)) - mean((NoiPat((c-1)*Par.ps2+1:c*Par.ps2, :) - CurPat((c-1)*Par.ps2+1:c*Par.ps2, :)).^2)));
            %             TempSigma_arrCh = sqrt(abs(repmat(Par.nSig0(c)^2, 1, size(CurPat, 2)) - mean((NoiPat((c-1)*Par.ps2+1:c*Par.ps2, :) - CurPat((c-1)*Par.ps2+1:c*Par.ps2, :)).^2)));
        else
            TempSigma_arrCh = Par.lambda*sqrt(max(0, repmat(Par.nSig0(c)^2, 1, size(CurPat, 2)) - mean((NoiPat((c-1)*Par.ps2+1:c*Par.ps2, :) - CurPat((c-1)*Par.ps2+1:c*Par.ps2, :)).^2)));
            %             TempSigma_arrCh = Par.lambda*sqrt(abs(repmat(Par.nSig0(c)^2, 1, size(CurPat, 2)) - mean((NoiPat((c-1)*Par.ps2+1:c*Par.ps2, :) - CurPat((c-1)*Par.ps2+1:c*Par.ps2, :)).^2)));
        end
        Sigma_arrCh((c-1)*Par.ps2+1:c*Par.ps2, :) = repmat(TempSigma_arrCh, [Par.ps2, 1]);
    end
    if (mod(iter-1, Par.Innerloop) == 0)
        Par.nlsp = Par.nlsp - 10;  % Lower Noise level, less NL patches
        NL_mat  =  Block_Matching(CurPat, Par);% Caculate Non-local similar patches for each
    end
    % Denoising by MCWNNM
    [Y_hat, W_hat]  =  MCWNNM_ADMM1_Estimation( NL_mat, Sigma_arrCh, CurPat, Par );   % Estimate all the patches
    rI = PGs2Image(Y_hat, W_hat, Par);
    PSNR  = csnr( I, rI, 0, 0 );
    SSIM      =  cal_ssim( I, rI, 0, 0 );
    fprintf( 'Iter = %2.3f, PSNR = %2.2f, SSIM = %2.2f \n', iter, PSNR, SSIM );
    Par.PSNR(iter, Par.image)  =   PSNR;
    Par.SSIM(iter, Par.image)      =  SSIM;
end
return;





