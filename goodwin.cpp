#pragma once
#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <cmath>
#include <boost/array.hpp>
#include <../odeint-v2/include/boost/numeric/odeint.hpp>


using namespace std;
using namespace boost::numeric::odeint;

const double phi0 = 0.0001;
const double phi1 = -0.0376;
const double alpha = 0.0129;
const double beta = 0.055;
const double delta = 0.055;
const double nu = 4.7055;

typedef boost::array< double, 2 > state_type;

void GW(const state_type& x, state_type& dxdt, double t)
{
    dxdt[0] = x[0]*(phi0/pow((1-x[1]),2)+phi1-alpha);
    dxdt[1] = x[1]*((1-x[0])/nu-alpha-beta-delta);
}

void write_GW(const state_type& x, const double t)
{
    cout << t << '\t' << x[0] << '\t' << x[1] << endl;
}

int main(int argc, char** argv)
{
    state_type x = { { 0.6 , 0.9 } }; // initial conditions
    integrate(GW, x, 0.0, 20.0, 0.1, write_GW);
}
