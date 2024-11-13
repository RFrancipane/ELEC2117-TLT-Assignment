using SIR_pkg
using Revise
using Plots

#define parameters for SIR model
c = 8 #8 Estimated contacts per person
β = 0.0352


#n = 10 #number of infection days
#p = 0.5 #chance of recovery in n days
γ = 1/7 # 1/10
ps = 0.2 #20% chance of serious infection
γs = 1/14 #serious infection for 14 days
α = 1/30 # 1 month till Susceptible

ϵ = 0.3
Φ = 0.6067
Φ_range = [0.476,0.609,0.768]
int_time = 35


params = [c,β,γ]

#pop starts at 10000, with one Infected
S = 9999
I = 1
Is = 0
R = 0

#simulate 6 months
tspan = [9,365/2]

#new data pre intervention


#new data
data = [21, 29, 25, 30, 28, 34, 28, 54, 57, 92, 73, 80, 109, 102, 128, 135, 163, 150, 211, 196, 233, 247, 283, 286, 332, 371, 390, 404, 467, 529]
data_time = [27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56]
data_s = [3, 3, 4, 7, 3, 8, 7, 5, 9, 13, 15, 3, 20, 13, 11, 20, 16, 11, 15, 18, 27, 24, 28, 36, 41, 35, 41, 55, 63, 66]
data_time_s = data_time

params = get_parameter_array(S, I, Is, R, c, β, γ, ps, γs, α, ϵ, Φ, int_time)
variable_params = [6,7,8,9]

#tspan[1] = find_start_time(params, 60, data, data_time, data_s, data_time_s, variable_params)
tspan[1] = 9

data = [21,29,25,30,28,34,28,54,57,92,73,80,109,102,128,135,163,150,211,196,233,247,283,286,332,371,390,404,467,529,598,641,704,702,788,856,854,955,995,1065,1106,1159,1217,1269,1298,1328,1339,1383,1431,1422,1414,1485,1464,1480]
data_s = [3,3,4,7,3,8,7,5,9,13,15,3,20,13,11,20,16,11,15,18,27,24,28,36,41,35,41,55,63,66,72,80,90,104,109,115,127,135,147,162,163,186,194,200,216,223,241,249,258,275,277,299,302,300]
data_time = [27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80]
data_time_s = data_time
#params = optimise_parameters(params, tspan, data, data_time, data_s, data_time_s, variable_params, 20)

#params = [9999.0, 1.0, 0.0, 0.0, 8.0, 0.038, 0.145, 0.134, 0.07, 0.03333333333333333, 0.3, 0.595, 35.0]
params = [9999.0, 1.0, 0.0, 0.0, 8.0, 0.038, 0.145, 0.134, 0.07, 0.03333333333333333, 0.3, 0.609, 35.0]

#Find β range
plot_error(params, tspan, data, data_time, 2, 6, [0.02,0.04], ["β", "β vs Mean Squared Error"])
β_range = get_parameter_range(params, tspan, data, data_time, [0.02,0.04],2, 6, 0.5)

params[6] = β_range[2]

plot_error(params, tspan, data_s, data_time_s, 3, 8, [0.05,0.3], ["ps", "ps vs Mean Squared Error"])
ps_range = get_parameter_range(params, tspan, data_s, data_time_s, [0.05,0.3],3, 8, 0.5)
params[8] = ps_range[2]




params = [9999.0,    1.0,    0.0,    0.0,    8.0,    0.035,    0.12,    0.163,    0.062,    0.03333333333333333,    0.3,    0.609,   35.0]
plot_range(params,tspan, data, data_time, β_range, 2, 6, ["SIRS Infected Population Prediction", "Time", "Infected Population", "DOH Infected Population Data"], 
            ["Worst case", "Mean case", "Best Case"])
plot_range(params,tspan, data, data_time, Φ_range, 2, 12, ["SIRS Infected Population Prediction", "Time", "Infected Population", "DOH Infected Population Data"], 
            ["Worst case", "Mean case", "Best Case"])
plot_range(params,tspan, data_s, data_time_s, Φ_range, 3, 12, ["SIRS Seriously Infected Population Prediction", "Time", "Seriously Infected Population", "DOH Data"],
            ["Worst case", "Mean case", "Best Case"])