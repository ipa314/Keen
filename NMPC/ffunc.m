
function dxdt=ffunc(x,p,cref)

u = sym('u',[1 3]);

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

%kappa function
    kx=1-x(1)-u(3)*x(3);
    k=k0+k1*atan(k2*kx+k3);
    
%Phillips curve
    phi = phi1/(1-x(2))^2-phi0;

    Fx = ( x(1)+ x(1)*(phi-u(1))-cref(1) )^2 +...
         ( x(2)+ x(2)*(k/nu-u(1)-u(2)-delta)-cref(2) )^2 +...
         ( x(3)+ x(3)*(u(3)-k/nu+delta)+k-(1-x(1))-cref(3) )^2;

    dxdt = matlabFunction(Fx,'Vars', {[u(1), u(2), u(3)]});

end
