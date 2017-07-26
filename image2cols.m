% -----------------------------------------------------------------------     
%Inputs:
% im:  the noisy image to be patchized
% pSz: the predefined size of patches
% stride: the predfined gap between neighbor patches
%
%Outputs:
% res: the set of decomposed patches
% -----------------------------------------------------------------------
function res = image2cols(im, pSz, stride)
  res = [];

  range_y = 1:stride:(size(im,1)-pSz+1);
  range_x = 1:stride:(size(im,2)-pSz+1);
  channel = size(im,3);
  if (range_y(end)~=(size(im,1)-pSz+1))
    range_y = [range_y (size(im,1)-pSz+1)];
  end
  if (range_x(end)~=(size(im,2)-pSz+1))
    range_x = [range_x (size(im,2)-pSz+1)];
  end
  sz = length(range_y)*length(range_x);

  tmp = zeros(pSz^2*channel, sz);

  idx = 0;
  for y=range_y
    for x=range_x
      p = im(y:y+pSz-1,x:x+pSz-1,:);
      idx = idx + 1;
      tmp(:,idx) = p(:);
    end
  end

  res = [res, tmp];
      


return

