function dxdt = EconKeen(t,x,p,u1,u2,u3)

% inputs of the model
% u1 = alpha, productivity growth
% u2 = beta , employment rate growth
% u3 = r %interest rate
% 

% parameters of the model
    delta = p.delta; %depreciation rate
    nu = p.nu; %capital-to-output ratio

% parameters for the Phillips curve
    phi0 = p.phi0;
    phi1 = p.phi1;

% parameters for the investment function kappa
    k0 = p.k0;
    k1 = p.k1;
    k2 = p.k2;
    k3 = p.k3;

% states of the model
% x(1) = omega 
% x(2) = lambda
% x(3) = debt

    k = kappa(x,k0,k1,k2,k3,u3);
    phi = Phi(x(2),phi0,phi1);

    Fx = [ x(1)*(phi-u1); ...
           x(2)*(k/nu-u1-u2-delta);...
           x(3)*(u3-k/nu+delta)+k-(1-x(1))];

    dxdt = Fx;

end


function k=kappa(x,k0,k1,k2,k3,u3)
     kx=1-x(1)-u3*x(3);
     k=k0+k1*atan(k2*kx+k3);

end

function p=Phi(x,phi0,phi1)
    p=phi1/(1-x)^2-phi0;

end