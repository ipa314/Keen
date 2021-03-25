#using Pkg
#Pkg.add("DifferentialEquations")
#Pkg.add("Plots")

using DifferentialEquations
using Plots

phi0=0.0001
phi1=-0.0376
phi=[phi0;phi1]
alpha=0.0129
beta=0.0337
delta=0.055
nu=4.7055

p=[phi0;phi1;alpha;beta;delta;nu]

function phill(x,p,t)
    p[1]/(1-x[2])^2+p[2]
end

function GW(dx,x,p,t)
    phill=phill!(x,p,t) # the symbol ! calls function outside
    dx[1] = x[1]*(phill-p[3])
    dx[2] = x[2]*((1-x[1])/p[6]-p[3]-p[4]-p[5])
end


r=0.03
kappa0=0.5
kappa1=-0.31831
kappa2=-63.989
kappa4=11.9914

pkappa=[kappa0;kappa1;kappa2;kappa4;r]
pkeen=[p;pkappa]


function kappainv(x,pkeen,t)
    pkeen[7]+pkeen[8]*atan(pkeen[9]*(1-x[1]-pkeen[11]*x[3])+pkeen[10])
end



# Keen model
function Keen_dxdt(dx,x,pkeen,t)
    k=kappainv(x,pkeen,t)
    phill=phill!(x,pkeen,t)
    dx[1]=x[1]*(phill-pkeen[3])
    dx[2]=x[2]*(k/pkeen[6]-pkeen[3]-pkeen[4]-pkeen[5])
    dx[3]=x[3]*(pkeen[11]-k/pkeen[6]+pkeen[5])+k-(1-x[1])
end


#Goodwin
xGW0 = [0.6;0.9]
tGWspan = (0,20.0)
probGW = ODEProblem(GW,xGW0,tGWspan,p)
solGW = solve(probGW)

plot(solGW,vars=(1,2))


#Keen
xKeen0 = [0.8;0.9;1]
tKeenspan = (0,150.0)
probKeen = ODEProblem(Keen_dxdt,xKeen0,tKeenspan,pkeen)
solKeen = solve(probKeen)

plot(solKeen,vars=(1,2,3))

