using CairoMakie
using LinearAlgebra
using Random
using BSplineKit
using Polynomials

xs = 1:11
ys = [1, 5, 8, 6, 5, 8, 10, 9, 8, 9, 13]
f = fit(xs, ys)

x = collect(1:0.01:11)
y = f.(x)

fig = Figure()
ax = Axis(fig[1, 1])
scatter!(ax, xs, ys, label = "support points", markersize = 25)
lines!(ax, x, y, label = "ground truth")
fig

stride = 50
xdata = x[1:stride:end]
ydata = y[1:stride:end]
scatter!(ax, xdata, ydata, label = "data", markersize = 10, color = :red)
fig

itp = interpolate(xdata, ydata, BSplineOrder(4))
lines!(ax, 1..11, itp, label = "fit")
fig