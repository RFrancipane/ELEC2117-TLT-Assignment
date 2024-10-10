using SIR_pkg
using Revise

#define parameters for SIR model
c = 8 #8 Estimated contacts per person
β = 0.05 # Transmission Probability
#β = 0.033 #manual fit

#n = 10 #number of infection days
#p = 0.5 #chance of recovery in n days
γ = 0.1 # 1/10
#SIR_pkg.time_cdf_gamma(n,p)

params = [c,β,γ]

#pop starts at 6000, with one Infected
S = 5999
I = 1
R = 0

#simulate 6 months
tspan = [0,365/2]

data = [11,7,20,3,29,14,11,12,16,10,58]

#data = [[0,1],[1,0],[2,5],[3,12],[4,0],[5,12],[6,0],[7,12],[8,11],[9,13],[10,0],[11,17],[12,41],[13,27],[14,20],[15,41],[16,47]]


#t = sol.test
#I_data = [sol(ti)[2] for ti in t]
#solution = SIR_pkg.simulate_model(pop0, params, tspan)
solution = SIR_pkg.simulate_model(S, I, R, c, β, γ, tspan)

time = [0,25.0]
plot_solution(solution,data,time)
