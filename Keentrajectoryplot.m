
% parameters according to Costa Lima PhD. Thesis
% parameters of the model
    p.delta=0.01; %depreciation rate
    p.nu=3; %capital-to-output ratio

% parameters of the Phillips curve
    p.phi0=0.0401042;
    p.phi1=0.000104167;

% parameters of the investment function kappa
    p.k0=0.5;
    p.k1=1/pi;
    p.k2=63.989;
    p.k3=-11.9914;


% initial inputs or initial parameters
    alpha0=0.025;
    beta0=0.02;
    r0=0.03;
    x0 = [0.62; 0.65; 9];%[0.8; 0.96; 0.1];
    tspan = [0 100];


odeKeen = @(t,x) EconKeen(t,x,p,alpha0,beta0,r0);
[t,xt] = ode45(odeKeen, tspan, x0);

% Plot solution
figure()
plttjr=plot3(xt(:,1),xt(:,2),xt(:,3))
xlabel('\omega(t)')
ylabel('\lambda(t)')
zlabel('d(t)')
grid on
title('Keen model')
%datatips
datatip(plttjr)
datatip(plttjr,xt(end,1),xt(end,2),xt(end,3))