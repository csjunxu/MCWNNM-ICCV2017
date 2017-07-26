function       blk_arr = Block_Matching( X, par)
% record the indexs of patches similar to the seed patch
blk_arr   =  zeros(par.nlsp, par.lenrc, 'single');
for  i  =  1 : par.lenrc
    seed = X(:, par.SelfIndex(i));
    neighbor = X(:, par.NeighborIndex(1:par.NumIndex(i), i));
    dis = sum(bsxfun(@minus, neighbor, seed).^2, 1);
    [~,ind]   =  sort(dis);
    indc        =  par.NeighborIndex( ind( 1:par.nlsp ), i );
%     indc(indc == par.SelfIndex(i)) = indc(1); % added on 08/01/2017
%     indc(1) = par.SelfIndex(i); % to make sure the first one of indc equals to off
    blk_arr(:, i) = indc;
end