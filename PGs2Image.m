function      im_out = PGs2Image(X, W, par)
% Reconstruction
im_out = zeros(par.h, par.w, par.ch);
im_wei = zeros(par.h, par.w, par.ch);
r = 1:1:par.maxr;
c = 1:1:par.maxc;
k = 0;
for l = 1:1:par.ch
    for i = 1:1:par.ps
        for j = 1:1:par.ps
            k = k+1;
            im_out(r-1+i, c-1+j, l)  =  im_out(r-1+i, c-1+j, l) + reshape( X(k,:)', [par.maxr par.maxc] );
            im_wei(r-1+i, c-1+j, l)  =  im_wei(r-1+i, c-1+j, l) + reshape( W(k,:)', [par.maxr par.maxc] );
        end
    end
end
im_out  =  im_out ./ im_wei;