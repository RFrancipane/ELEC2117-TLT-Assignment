using SIR_pkg
using Revise
using Plots

#define parameters for SIR model
c = 8 #8 Estimated contacts per person
β = 0.0352
β_vals = [0.0318, 0.0352, 0.0374]


#n = 10 #number of infection days
#p = 0.5 #chance of recovery in n days
γ = 1/7 # 1/10
ps = 0.2 #20% chance of serious infection
γs = 1/14 #serious infection for 14 days
α = 1/30 # 1 month till Susceptible

ϵ = 0.3
Φ = 0.8
int_time = 30


params = [c,β,γ]

#pop starts at 6000, with one Infected
S = 5999
I = 1
Is = 0
R = 0

#simulate 6 months
tspan = [0,365/2]



#new data
data = [11,7,20,3,29,14,11,12,16,10,58,34,26,29,51,55]
data_time = [15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
data_s = [0,0,1,2,5,5,5,2,9,4]
data_time_s = [21,22,23,24,25,26,27,28,29,30]

β_vals = get_beta_range(S, I, Is, R, c, γ, ps, γs, α, tspan, data, data_time, data_s, data_time_s, β_range, 0.5)
println(β_vals)

params = [S, I, Is, R, c, β, γ, ps, γs, α, ϵ, Φ, int_time]

plot_range(params, tspan, data, data_time, β_vals, 2, 6, ["SIRS Infected Population Prediction", "Time", "Infected Population", "DOH Infected Population Data"],
            ["Worst case", "Mean case", "Best Case"])

plot_range(params, tspan, data_s, data_time_s, β_vals, 3, 6, ["SIRS Seriously Infected Population Prediction", "Time", "Seriously Infected Population", "DOH Data"],
            ["Worst case", "Mean case", "Best Case"])
