using CairoMakie
using LinearAlgebra
using Random
using BSplineKit
using Polynomials

xs = 1:6
ys = [1, 6, 7, 6, 5.5, 8]
fgt = fit(xs, ys, 3)

x = collect(1:0.01:6)
y = fgt.(x)
ynoisy = y .+ 0.1 * randn(length(x))
idx = (1 .<= x .<= 2.5) .|| (5 .<= x .<= 6) 
ydata = ynoisy[idx]

fig = Figure()
ax = Axis(fig[1, 1])
scatter!(ax, xs, ys, label = "support points", markersize = 25)
lines!(ax, x, y, label = "ground truth")
scatter!(ax, x[idx], ydata, label = "data", markersize = 5, color = :red)
fig

f3 = fit(x[idx], ydata, 3)
yfit = f3.(x)
lines!(ax, x, yfit, label = "fit", linestyle = :dash)
axislegend(ax, position = :rb)
fig

xnow = 2
ynow = 6
c = f3.coeffs
coffset = copy(c)
coffset[1] -= ynow
poffset = Polynomial(coffset)
@btime xoffset = roots(poffset)
f3(xoffset[3])