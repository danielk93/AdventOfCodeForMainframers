/* REXX */

x = bpxwunix('cat /z/zuserid/aoc23/day13solutioninput.txt',,file.,se.)

/* Sample data
file.1 = '#.##..##.'
file.2 = '..#.##.#.'
file.3 = '##......#'
file.4 = '##......#'
file.5 = '..#.##.#.'
file.6 = '..##..##.'
file.7 = '#.#.##.#.'
file.8 = ''
file.9 = '#...##..#'
file.10= '#....#..#'
file.11= '..##..###'
file.12= '#####.##.'
file.13= '#####.##.'
file.14= '..##..###'
file.15= '#....#..#'
file.0 = 15
*/

patterns. = ''
patterns.0 = 0
pattern = 1

p1 = 0

l = 0
do i = 1 to file.0 + 1         /* to account for grabbing last */
  if file.i = ' ' | i > file.0 then do
    patterns.pattern.0 = l     /* Number of lines in current pattern */
    patterns.0 = pattern       /* Number of patterns */
    pattern = pattern + 1      /* Next pattern please */
    l = 0                      /* Reset line counter */
  end
  else do
    l = l + 1
    patterns.pattern.l = file.i
  end
end

/* See what we've done */
do i = 1 to patterns.0
  r = checkrows(i)
  c = checkcols(i)
  if r <> '' then p1 = p1 + (100*r)
  if c <> '' then p1 = p1 + c
end

say "Total sum:" p1
exit

checkrows: procedure expose patterns.
  parse arg patt
  res = ''
  /* check for identical rows */
  prev = ''
  do i = 1 to patterns.patt.0
    if patterns.patt.i = prev then do
      iter = 1
      res = i - 1
      do a = i - 2 to 1 by - 1
        b = i + iter
        if a < 1 | b > patterns.patt.0 then iterate
          if patterns.patt.a <> patterns.patt.b then do
            res = ''
            leave
          end
        iter = iter + 1
      end
      if res <> '' then leave
    end
    else
      prev = patterns.patt.i
  end
  return res

checkcols: procedure expose patterns.
  parse arg patt
  new. = ''
  new.0 = length(patterns.patt.1)
  /* create lookup thing...rotated stem then do check rows code */
  do i = 1 to length(patterns.patt.1)
    newline = ''
    do j = 1 to patterns.patt.0
      newline = newline || substr(patterns.patt.j,i,1)
    end
    new.i = newline
  end
  
  /* if only we could pass stems to functions
     we could run new.i in our checkrows func
     now we copy and amend the code ;)
  */
  res = ''
  /* check for identical rows */
  prev = ''
  do i = 1 to new.0
    if new.i = prev then do
      iter = 1
      res = i - 1
      do a = i - 2 to 1 by - 1
        b = i + iter
        if a < 1 | b > new.0 then iterate
          if new.a <> new.b then do
            res = ''
            leave
          end
        iter = iter + 1
      end
      if res <> '' then leave
    end
    else
      prev = new.i
  end
  return res