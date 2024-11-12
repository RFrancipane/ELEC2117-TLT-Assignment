using SIR_pkg
using Revise

#define parameters for SIR model
c = 8 #8 Estimated contacts per person
β = 0.036 # Transmission Probability


γ = 1/7 #7 days to recover
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
#data = [[0,1],[1,0],[2,5],[3,12],[4,0],[5,12],[6,0],[7,12],[8,11],[9,13],[10,0],[11,17],[12,41],[13,27],[14,20],[15,41],[16,47]]


#t = sol.test
#I_data = [sol(ti)[2] for ti in t]
#solution = SIR_pkg.simulate_model(pop0, params, tspan)
solution = simulate_model(S, I, Is, R, c, β, γ, ps, γs, α, tspan)


plot_solution(solution,2,data,data_time, ["Infected population model", "Time", "Population Infected", "SIRS Model", "DOH Data"])


plot_solution(solution,3,data_s,data_time_s, ["Seriously Infected population model", "Time", "Population Seriously Infected", "SIRS Model", "DOH Data"])
plot_solution_SIRS(solution)

println(get_R0(c, β, γ))