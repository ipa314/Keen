
% controllers
lbalpha=-2;
lbbeta=-2;
lbr=0;
ubalpha=2;
ubbeta=2;
ubr=4;

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
    
    
 % load reference signal
    load cref.mat
 % interpolate reference signal
    tlapse=size(cref,1);
    tq=1:0.25:21;
    tlapse2=size(tq,2);
    cref2=zeros(tlapse2,3);
    cref2(:,1)=interp1(1:tlapse,cref(:,1),tq);
    cref2(:,2)=interp1(1:tlapse,cref(:,2),tq);
    cref2(:,3)=interp1(1:tlapse,cref(:,3),tq);
 % tracking

x0 = cref(1,:);
x0temp=x0;
u=[0 0 0];
x=cref2(1,:);
options = optimoptions('fmincon','display','none')
 for i=1:tlapse2-2

    %objfun=ffunc(x0temp,p,cref2(i+1,:));
    %utemp = fmincon(objfun,[0 0 0],[],[],[],[],...
    %    [lbalpha lbbeta lbr],[ubalpha ubbeta ubr]);
    objfun=f2func(x0temp,p,cref2(i+1:i+2,:));
    utemp = fmincon(objfun,[0 0 0 0 0 0],[],[],[],[],...
        [lbalpha lbbeta lbr lbalpha lbbeta lbr],...
        [ubalpha ubbeta ubr ubalpha ubbeta ubr],[],options);
    u=[u;utemp(1:3)];
    x0temp=disEconKeen(x0temp,p,u(i,1),u(i,2),u(i,3))';
    x=[x;x0temp];
    
 end
 
u(1,:)=[];
su=size(u,1);
 
figure()
plot3(x(:,1),x(:,2),x(:,3))
hold on
plot3(cref2(:,1),cref2(:,2),cref2(:,3))
xlabel('Omega');
ylabel('Lambda');
zlabel('debt');

figure()
subplot(2,3,1)
plot(x(:,1))
hold on
plot(cref2(:,1))
xlabel('t');
ylabel('Omega');
xlim([1 tlapse2])
subplot(2,3,2)
plot(x(:,2))
hold on
plot(cref2(:,2))
xlabel('t');
ylabel('Lambda');
xlim([1 tlapse2])
subplot(2,3,3)
plot(x(:,3))
hold on
plot(cref2(:,3))
xlabel('t');
ylabel('debt');
xlim([1 tlapse2])

subplot(2,3,4)
plot(u(:,1))
xlabel('t');
ylabel('Alpha');
xlim([1 su])
subplot(2,3,5)
plot(u(:,2))
xlabel('t');
ylabel('Beta');
xlim([1 su])
subplot(2,3,6)
plot(u(:,3))
xlabel('t');
ylabel('r');
xlim([1 su])
