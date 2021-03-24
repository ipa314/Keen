# Simulation of Goodwin and Keen models


# libraries
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint
import matplotlib.pyplot as plt
from mpl_toolkits import mplot3d

#
# define functions
#

# Phillips curve
def phill(x2,phi0,phi1):
    return phi0/(1-x2)**2+phi1

# Goodwin model
def GW_dxdt(x,t,alpha,beta,delta,nu):
    x1,x2=x
    dxdt=[x1*(phill(x2,phi0,phi1)-alpha),x2*((1-x1)/nu-alpha-beta-delta)]
    return dxdt 

# Investment function
def kappainv(x,kappa0,kappa1,kappa2,kappa4):
    x1,x3=x
    return kappa0+kappa1*np.arctan(kappa2*(1-x1-r*x3)+kappa4)

# Keen model
def Keen_dxdt(x,t,alpha,beta,delta,nu,r):
    x1,x2,x3=x
    k=kappainv([x1,x3],kappa0,kappa1,kappa2,kappa4)
    dxdt=[x1*(phill(x2,phi0,phi1)-alpha),
          x2*(k/nu-alpha-beta-delta),
          x3*(r-k/nu+delta)+k-(1-x1)]
    return dxdt 
    
    
#
# parameters of the models
#
    
    
#Goodwin parameters
phi0=0.0001
phi1=-0.0376
alpha=0.0129
beta=0.0337
delta=0.055
nu=4.7055

#Keen parameters
r=0.03
kappa0=0.5
kappa1=-0.31831
kappa2=-63.989
kappa4=11.9914


#
# parameters of the simulation
#

#initial points
xGW0=[0.6,0.9] #Goodwin
xKeen0=[0.75,0.94,1] #Keen

#time horizon
tfGW= 20
tfKeen= 150
tGW = np.linspace(0, tfGW, 101)
tKeen = np.linspace(0, tfKeen, 101)



#
# plots
#


solGW = odeint(GW_dxdt, xGW0, tGW, args=(alpha,beta,delta,nu))
plt.figure(1)
plt.plot(solGW[:, 0],solGW[:, 1],'k', label=r'$(\omega(t),\lambda(t)$',linewidth=1)
plt.legend(loc='best')
plt.title('Goodwin Model')
plt.xlabel(r'$\omega(t)$')
plt.ylabel(r'$\lambda(t)$')
plt.grid()
plt.show()


solKeen = odeint(Keen_dxdt, xKeen0, tKeen, args=(alpha,beta,delta,nu,r))
plt.figure(2,figsize=(10, 10), dpi=80, facecolor='w', edgecolor='k')
ax = plt.axes(projection ='3d')
ax.xaxis.pane.fill = False
ax.yaxis.pane.fill = False
ax.zaxis.pane.fill = False
ax.plot(solKeen[:, 0],solKeen[:, 1],solKeen[:, 2], 'green',label=r'$(\omega(t),\lambda(t),d(t))$')
ax.legend()
ax.set_title('Keen Model')
ax.set_xlabel(r'$\omega(t)$')
ax.set_ylabel(r'$\lambda(t)$')
ax.set_zlabel(r'$d(t)$')
plt.grid()
plt.show()
