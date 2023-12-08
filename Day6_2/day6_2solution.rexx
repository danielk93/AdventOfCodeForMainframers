/* REXX */

NUMERIC DIGITS 31

file.1 = "Time: 53 71 78 80"
file.2 = "Distance: 275 1181 1215 1524"

times. = ''
dists. = ''
times.0 = 1
dists.0 = 1

do i = 2 to words(file.1)
  times.1 = times.1|| word(file.1,i)
  dists.1 = dists.1|| word(file.2,i)
end

say "times as one word:" times.1
say "dist as one word:" dists.1" (distance to beat)"
dists.1 = dists.1 + 1

D = (times.1 * times.1) - (4*-1*-dists.1)

root = sqrt(D)
root1  =((-1 * times.1) + root)/ -2
root2  =((-1 * times.1) - root)/ -2

parse var root1 r1"."rrest1
parse var root2 r2"."rrest2

if rrest1 <> '' then r1 = r1 + 1

say "Day6_2 Total:" abs(r1-r2) + 1
exit

sqrt: procedure
  parse arg val
  xnew = val
  eps = 0.5 * 10**(1+fuzz()-digits())
  do until abs(xold-xnew) < (eps*xnew)
    xold = xnew
    xnew = 0.5 * (xold+val/xold)
  end

  return xnew