# HOW TO: Interpolate strings with variables

library('GetoptLong')

temperature <- 77.4
latlong <- c(12.9667, 77.5667)

o <- qq("The temperature is: @{temperature}")
o <- qq("The temperature is: @{temperature} at lat-long (@{latlong[1]}, @{latlong[2]})")
qqcat("The temperature is: @{temperature} \nat lat-long (@{latlong[1]}, @{latlong[2]})")

