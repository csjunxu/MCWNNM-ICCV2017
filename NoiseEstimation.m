% -----------------------------------------------------------------------     
%Inputs:
% im_noisy:  the noisy image whose noise level requires to be estimated
% PatchSize: the predefined size of patches
% 
%Outputs:
% estsigma: Estimated result given by our method
% -----------------------------------------------------------------------
function estsigma =NoiseEstimation(im_noisy,PatchSize)

p_out = image2cols(im_noisy, PatchSize, 3);

mu = mean(p_out,2);
sigma=(p_out-repmat(mu,[1,size(p_out,2)])) ...
        *(p_out-repmat(mu,[1,size(p_out,2)]))'/(size(p_out,2));
eigvalue = (sort((eig(sigma)),'ascend'));
 
for CompCnt = size(p_out,1):-1:1
    Mean = mean(eigvalue(1:CompCnt));
    
    if(sum(eigvalue(1:CompCnt)>Mean) == sum(eigvalue(1:CompCnt)<Mean))
        break
    end
   
end
estsigma = sqrt(Mean);
