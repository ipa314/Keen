
function dxdt=f2func(x,p,cref)

u = sym('u',[1 6]);

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

%Phillips curve
    phi = phi1/(1-x(2))^2-phi0;
    

%kappa function
    kx=1-x(1)-u(3)*x(3);
    k=k0+k1*atan(k2*kx+k3);
    
    

    
    x21=x(1)+ x(1)*(phi-u(1));
    x23=x(3)+ x(3)*(u(3)-k/nu+delta)+k-(1-x(1));
    kx2=1-x21-u(6)*x23;
    kk=k0+k1*atan(k2*kx2+k3);
    x22=x(2)+ x(2)*(kk/nu-u(1)-u(2)-delta);
    phi2 = phi1/(1-x22)^2-phi0;
    
    
    Fx = 1000*( x(1)+ x(1)*(phi-u(1))-cref(1,1) )^2 +...
         1000*( x(2)+ x(2)*(k/nu-u(1)-u(2)-delta)-cref(1,2) )^2 +...
         1000*( x(3)+ x(3)*(u(3)-k/nu+delta)+k-(1-x(1))-cref(1,3) )^2 +... %%%%
         ( x21+ x21*(phi2-u(4))-cref(2,1) )^2 +...
         ( x22+ x22*(kk/nu-u(4)-u(5)-delta)-cref(2,2) )^2 +...
         ( x23+ x23*(u(6)-kk/nu+delta)+kk-(1-x21)-cref(2,3) )^2 +...
         1000*( u(1)-u(4) )^2 +...
         1000*( u(2)-u(5) )^2 +...
         1000*( u(3)-u(6) )^2 ;

    dxdt = matlabFunction(Fx,'Vars', {[u(1), u(2), u(3), u(4), u(5), u(6)]});

end
