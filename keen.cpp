#pragma once
#define _CRT_SECURE_NO_WARNINGS
#define _USE_MATH_DEFINES
#include <iostream>
#include <fstream>
#include <cmath>
#include <math.h>
#include <boost/array.hpp>
#include <../odeint-v2/include/boost/numeric/odeint.hpp>


using namespace std;
using namespace boost::numeric::odeint;

# parameters of the model
const double delta = 0.01;
const double nu = 3;

# parameters of the Phillips curve
const double phi0 = 0.0401042;
const double phi1 = 0.000104167;

# parameters of the investment function kappa
const double k0 = 0.5;
const double k1 = 1/M_PI;
const double k2 = 63.989;
const double k3 = -1.9914;

# initial inputs or initial parameteres
const double alpha0 = 0.0129;
const double beta0 = 0.02;
const double r0 = 0.03;
const double x0 = {0.8,0.96,0.1};
const double tspan = 100;
  
  


typedef boost::array< double, 3 > state_type;

void keen(const state_type& x, state_type& dxdt, double t)
{
    dxdt[0] = x[0]*(phi1/pow((1-x[1]),2)-phi0-alpha);
    dxdt[1] = x[1]*( ( k0+k1*atan( k2*(1-x(0)-r0*x(2)) + k3 ) )/nu-alpha-beta-delta );
    dxdt[2] = x[2]*(r0-( k0+k1*atan( k2*(1-x(0)-r0*x(2)) + k3 ) )/nu+delta)+( k0+k1*atan( k2*(1-x(0)-r0*x(2)) + k3 ) )-(1-x(0));
}


int main(int argc, char** argv)
{
  ofstream myfile ("keen.txt");
  if (myfile.is_open())
  {
    for (double i=0;i<;){   ###specify range
      for (double j=0;j<;){    ##specify range
        for (double k=0;k<10;){  ##specify range
              state_type x = {{i,j,k}}; // initial condition
              xtrj=integrate(keen, x, 0.0, tspan, 0.01);    #### declare xtrj, 
              if (xend == xeq){                ## declare xend and equal to end point of xtrj,   find equilibrium
              myfile << x[0]<<" "<<x[1]<<" "<<x[2]<<"\n";
                              }
        } 
      }
    }
  myfile.close();
  }

}
