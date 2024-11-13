using SIR_pkg
using Revise
using Plots

#define parameters for SIR model
c = 8 #8 Estimated contacts per person
β = 0.0345


γ = 1/7 #7 days to recover
ps = 0.2 #20% chance of serious infection
γs = 1/14 #serious infection for 14 days
α = 1/30 # 1 month till Susceptible

ϵ = 0.3
Φ = 0.8
int_time = 30

#pop starts at 6000, with one Infected
S = 5999
I = 1
Is = 0
R = 0

#simulate 6 months
tspan = [0,365/2]
β_vals = [0.0329, 0.0345, 0.0357]
#new data pre intervention

data = [11,7,20,3,29,14,11,12,16,10,58,34,26,29,51,55,155,53,67,98,130,189,92,192,145,128,68,74,126,265,154,207,299,273,190,152,276,408,267,462,352,385]
data_time = [15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56]
data_s = [0,0,1,2,5,5,5,2,9,4,22,0,15,48,38,57,9,18,20,0,41,15,35,36,27,38,24,40,34,57,18,29,63,66,119,76]
data_time_s = [21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56]
params = get_parameter_array(S, I, Is, R, c, β, γ, ps, γs, α, ϵ, Φ, int_time)

plot_range(params, tspan, data, data_time, β_vals, 2, 6, ["SIRS Infected Population Prediction", "Time", "Infected Population", "DOH Infected Population Data"],
            ["Worst case", "Mean case", "Best Case"])

plot_range(params, tspan, data_s, data_time_s, β_vals, 3, 6, ["SIRS Seriously Infected Population Prediction", "Time", "Seriously Infected Population", "DOH Data"],
            ["Worst case", "Mean case", "Best Case"])



data_post_intervention = data[17:end]
data_time_post_intervention = data_time[17:end]
plot_error(params, tspan, data_post_intervention, data_time_post_intervention, 2, 12, [0.4,0.9], ["Φ", "Φ vs Mean Squared Error (Time > 30 Days)"])
Φ_range = get_parameter_range(params, tspan, data_post_intervention, data_time_post_intervention, [0.4,0.9],2, 12, 0.5)

append!(Φ_range, 0)
plot_range(params,tspan, data, data_time, Φ_range, 2, 12, ["SIRS Infected Population Prediction", "Time", "Infected Population", "DOH Infected Population Data"], 
            ["Worst case", "Mean case", "Best Case", "No Intervention"])

plot_range(params,tspan, data_s, data_time_s, Φ_range, 3, 12, ["SIRS Seriously Infected Population Prediction", "Time", "Seriously Infected Population", "DOH Data"],
            ["Worst case", "Mean case", "Best Case", "No Intervention"])


#test with final data
data = [11,7,20,3,29,14,11,12,16,10,58,34,26,29,51,55,155,53,67,98,130,189,92,192,145,128,68,74,126,265,154,207,299,273,190,152,276,408,267,462,352,385,221,420,544,329,440,427,369,606,416,546,475,617,593,352,337,473,673,653,523,602,551,686,556,600]
data_s = [0,0,1,2,5,5,5,2,9,4,22,0,15,48,38,57,9,18,20,0,41,15,35,36,27,38,24,40,34,57,18,29,63,66,119,76,95,28,109,136,119,104,121,93,147,129,130,161,133,136,138,139,181,181,218,183,167,164,219,220]
data_time = [15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80]
data_time_s = [21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80]
plot_range(params,tspan, data, data_time, Φ_range[1:3], 2, 12, ["SIRS Infected Population Prediction", "Time", "Infected Population", "DOH Infected Population Data"], 
            ["Worst case", "Mean case", "Best Case"])
plot_range(params,tspan, data_s, data_time_s, Φ_range[1:3], 3, 12, ["SIRS Seriously Infected Population Prediction", "Time", "Seriously Infected Population", "DOH Data"],
            ["Worst case", "Mean case", "Best Case"])
