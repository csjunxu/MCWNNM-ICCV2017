% ===============================================================
The code in this package implements the Multi-channel Weighted Nuclear Norm Minimization
(MCWNNM) model for real color image denoising as described in the following paper:

 @article{MCWNNM,
 	author = {Jun Xu and Lei Zhang and David Zhang and Xiangchu Feng},
 	title = {Multi-channel Weighted Nuclear Norm Minimization for Real Color Image Denoising},
 	journal = {ICCV},
 	year = {2017}
 }

Please cite the paper if you are using this code in your research.
Please see the file License.txt for the license governing this code.

  Version:       1.0 (26/07/2017), see ChangeLog.txt
  Contact:       Jun Xu <csjunxu@comp.polyu.edu.hk, nankaimathxujun@gmail.com>
% ===============================================================

Notice:
------------
We are still optimize the code.

Overview
------------
The function "Demo_MCWNNM_ADMM[1|2]" demonstrates color image denoising with the MCWNNM
models introduced in the paper. They use the same model, but with different settings. You can choose 
any setting for your purpose.

The function "Demo_MCWNNM_ADMM1_NL_RealGT" demonstrates real color image denoising with 
"ground truth" by the MCWNNM models introduced in the paper.

The function "Demo_MCWNNM_ADMM1_NL_RealNoGT" demonstrates real color image denoising 
without "ground truth" by the MCWNNM models introduced in the paper.


Data
------------
Please download the data on my personal website.

1. kodak_color: 24 high quality color images from Kodak PhotoCD dataset
2. NoiseClinicImages: real noisy images with no ''ground truth''
3. Real_ccnoise_denoised_part: 15 cropped real noisy images from CC [18]. 
                                                The *real.png are noisy images;
                                                The *mean.png are "ground truth" images;
                                                The *real.png are denoised images by CC.

Dependency
------------
This code is implemented purely in Matlab2014b and doesn't depends on any other toolbox.

Contact
------------
If you have questions, problems with the code, or find a bug, please let us know. Contact Jun Xu at 
csjunxu@comp.polyu.edu.hk or nankaimathxujun@gmail.com.
