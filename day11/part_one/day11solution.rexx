/* REXX*/

x = bpxwunix('cat /z/zuserid/aoc2023/day11solutioninput.txt',,file.,se.)

/* Sample data
file.1 = '...#......'
file.2 = '.......#..'
file.3 = '#.........'
file.4 = '..........'
file.5 = '......#...'
file.6 = '.#........'
file.7 = '.........#'
file.8 = '..........'
file.9 = '.......#..'
file.10= '#...#.....'
file.0 = 10
*/

galaxies. = '' /* we store galaxy locations here */
galaxies.0 = 0

expand_i = 0
width = length(file.1)

do i = 1 to file.0

  if checkrow(i) = 0 then expand_i = expand_i + 1
  expand_j = 0
  do j = 1 to width
    if checkcol(j) = 0 then expand_j = expand_j + 1
    if substr(file.i,j,1) = '#' then do
      /* store our galaxy location including offset */
      newgal = galaxies.0 + 1
      galaxies.newgal = j + expand_j","i + expand_i
      galaxies.0 = newgal
    end
  end
end

/*
do i = 1 to galaxies.0
  say i "at" galaxies.i
end
*/
/* Time to get all permuations of all galaxy combos */
pairs. = 0
do i = 1 to galaxies.0
  do j = 1 to galaxies.0
    if i = j then iterate
    if i > j then iterate
    newpair = pairs.0 + 1
    pairs.newpair = i j
    pairs.0 = newpair
  end
end

p1 = 0
/* say pairs.0 "pairs of galaxies" */
do i = 1 to pairs.0
  parse var pairs.i a b
  p1 = p1 + dist(a,b)
end

say "Total sum:" p1

exit

checkcol: procedure expose file.
  parse arg col
  gals     = 0
  do i = 1 to file.0
    if substr(file.i,col,1) = '#' then gals = gals + 1
  end
  return gals

checkrow: procedure expose file.
  parse arg row
  gals     = 0
  do i = 1 to length(file.row)
    if substr(file.row,i,1) = '#' then gals = gals + 1
  end
  return gals

dist: procedure expose galaxies.
  parse arg a,b
  /* taxicab distance from a to b */
  parse var galaxies.a xa","ya
  parse var galaxies.b xb","yb

  return abs(xa-xb) + abs(ya-yb)

exit