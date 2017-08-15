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
1. We are still optimize the code. In fact, this model can achieve much better performance followed by the
suggestions in the file ''PossibleExtension.txt''. 

2. The optimized code is provided in https://github.com/csjunxu/MCWNNM_ICCV2017.

3. If you want to follow this work and has no ideas, please read ''PossibleExtension.txt''.

Overview
------------
The function "Demo_MCWNNM_ADMM[1||2]" demonstrates color image denoising with the MCWNNM
models introduced in the paper. They use the same model, but with different settings. You can choose 
any setting for your purpose.

The function "Demo_MCWNNM_ADMM1_NL_RealGT" demonstrates real color image denoising with 
"ground truth" by the MCWNNM models introduced in the paper.

The function "Demo_MCWNNM_ADMM1_NL_RealNoGT" demonstrates real color image denoising 
without "ground truth" by the MCWNNM models introduced in the paper.


Data
------------
Please download the data from corresponding addresses.
1. kodak_color: 24 high quality color images from Kodak PhotoCD dataset
                        This dataset can be found at http://r0k.us/graphics/kodak/
2. NoiseClinicImages: real noisy images with no ''ground truth''
                        This dataset can be found at http://demo.ipol.im/demo/125/
3. Real_ccnoise_denoised_part: 15 cropped real noisy images from CC [1]. 
                        This dataset can be found at  http://snam.ml/research/ccnoise
                        The smaller 15 cropped images can be found on in the directory 
                        ''Real_ccnoise_denoised_part'' of 
                        https://github.com/csjunxu/MCWNNM_ICCV2017
                                                The *real.png are noisy images;
                                                The *mean.png are "ground truth" images;
                                                The *ours.png are images denoised by CC.

[1] A Holistic Approach to Cross-Channel Image Noise Modeling and its Application to Image Denoising. 
     Seonghyeon Nam*, Youngbae Hwang*, Yasuyuki Matsushita, Seon Joo Kim, CVPR, 2016.

Dependency
------------
This code is implemented purely in Matlab2014b and doesn't depends on any other toolbox.

Contact
------------
If you have any questions or suggestions with the code, or find a bug, please let us know. 
Contact Jun Xu at csjunxu@comp.polyu.edu.hk or nankaimathxujun@gmail.com.


Update:
1. 08/15/2017: Complement the "PGs2Image.m" function. 
Thanks Zi-Fa Han for pointingout the missing of this function. 
