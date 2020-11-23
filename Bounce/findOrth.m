function [vecB1 vecB2] = findOrth(omega)
nOmega = omega/(norm(omega));
orth = null(nOmega(:).');
vecB1 = orth(:,1);
vecB2 = orth(:,2);