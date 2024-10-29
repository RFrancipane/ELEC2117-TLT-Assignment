using SIR_pkg
using Revise
using Plots

#define parameters for SIR model
c = 8 #8 Estimated contacts per person
#β = 0.031 # Transmission Probability
β_range = [0.03, 0.04]


#n = 10 #number of infection days
#p = 0.5 #chance of recovery in n days
γ = 1/7 # 1/10
ps = 0.2 #20% chance of serious infection
γs = 1/14 #serious infection for 14 days
α = 1/30 # 1 month till Susceptible


params = [c,β,γ]

#pop starts at 6000, with one Infected
S = 5999
I = 1
Is = 0
R = 0

#simulate 6 months
tspan = [0,365/2]



data = [11,7,20,3,29,14,11,12,16,10,58]
data_time = [15,16,17,18,19,20,21,22,23,24,25]

data_s = [0,0,1,2,5]
data_time_s = [21,22,23,24,25]


sol = simulate_model