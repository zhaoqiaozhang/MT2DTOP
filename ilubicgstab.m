function [x, err,iter] = ilubicgstab(K, P,maxit,tol)
    [L U]=ilu(K);
    [x , err,iter]= bicgstab(K,P,tol,maxit,L,U);
 
end