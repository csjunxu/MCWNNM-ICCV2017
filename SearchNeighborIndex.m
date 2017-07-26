function  par  =  SearchNeighborIndex(par)
% This Function Precompute the all the patch indexes in the Searching window
% -NeighborIndex is the array of neighbor patch indexes for each keypatch
% -NumIndex is array of the effective neighbor patch numbers for each keypatch
% -SelfIndex is the index of keypatches in the total patch index array
par.maxr = par.h - par.ps + 1;
par.maxc = par.w - par.ps + 1;
r          =  1:par.step:par.maxr;
par.r          =  [r r(end) + 1:par.maxr];
c          =  1:par.step:par.maxc;
par.c          =  [c c(end) + 1:par.maxc];
par.lenr = length(par.r);
par.lenc = length(par.c);
par.ps2 = par.ps^2;
par.ps2ch = par.ps2 * par.ch;
% Total number of patches in the test image
par.maxrc = par.maxr * par.maxc;
% Total number of seed patches being processed
par.lenrc = par.lenr * par.lenc;
% index of each patch in image
par.Index     =   (1:par.maxrc);
par.Index    =   reshape(par.Index, par.maxr, par.maxc);
% preset variables for all the patch indexes in the Searching window
par.NeighborIndex    =   int32(zeros(4 * par.win^2, par.lenrc));
par.NumIndex        =   int32(zeros(1, par.lenrc));
par.SelfIndex   =   int32(zeros(1, par.lenrc));

for  i  =  1 : par.lenr
    for  j  =  1 : par.lenc
        row = par.r(i);
        col = par.c(j);
        off = (col-1) * par.maxr + row;
        off1 = (j-1) * par.lenr + i;
        
        % the range indexes of the window for searching the similar patches
        rmin    =   max( row - par.win, 1 );
        rmax    =   min( row + par.win, par.maxr );
        cmin    =   max( col - par.win, 1 );
        cmax    =   min( col + par.win, par.maxc );
        
        idx     =   par.Index(rmin:rmax, cmin:cmax);
        idx     =   idx(:);
        
        par.NumIndex(off1)  =  length(idx);
        par.NeighborIndex(1:par.NumIndex(off1), off1)  =  idx;
        par.SelfIndex(off1) = off;
    end
end
