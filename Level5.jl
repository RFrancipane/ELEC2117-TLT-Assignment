using SIR_pkg
using Revise
using Plots

#define parameters for SIR model
c = 8 #8 Estimated contacts per person
β = 0.0352


#n = 10 #number of infection days
#p = 0.5 #chance of recovery in n days
γ = 1/7 # 1/10
ps = 0.1825 #20% chance of serious infection
γs = 1/14 #serious infection for 14 days
α = 1/30 # 1 month till Susceptible

ϵ = 0.3
Φ = 0.6067
int_time = 35


params = [c,β,γ]

#pop starts at 10000, with one Infected
S = 9999
I = 1
Is = 0
R = 0

#simulate 6 months
tspan = [5,365/2]

#new data pre intervention


#new data
data = [21,29,25,30,28,34,28,54,57,92,73,80,109,102,128,135,163,150,211,196,233,247,283,286,332,371,390,404,467,529,598,641,704,702,788,856,854,955,995,1065,1106,1159,1217,1269,1298,1328,1339,1383,1431,1422,1414,1485,1464,1480]
data_time = [27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80]
data_s = [3,3,4,7,3,8,7,5,9,13,15,3,20,13,11,20,16,11,15,18,27,24,28,36,41,35,41,55,63,66,72,80,90,104,109,115,127,135,147,162,163,186,194,200,216,223,241,249,258,275,277,299,302,300]
data_time_s = data_time

solution = simulate_model(S, I, Is, R, c, β, γ, ps, γs, α, ϵ, Φ, int_time, tspan)
params = get_parameter_array(S, I, Is, R, c, β, γ, ps, γs, α, ϵ, Φ, int_time)
variable_params = [6,7,8,9,10,12]

plot_solution(solution,2,data,data_time, ["Infected population model", "Time", "Population Infected", "SIRS Model", "DOH Data"])


plot_solution(solution,3,data_s,data_time_s, ["Seriously Infected population model", "Time", "Population Seriously Infected", "SIRS Model", "DOH Data"])

params = optimise_parameters(params, tspan, data, data_time, data_s, data_time_s, variable_params, 4)