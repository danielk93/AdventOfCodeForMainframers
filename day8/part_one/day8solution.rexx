/* REXX */

x = bpxwunix('cat /z/zuserid/aoc2023/day8solutioninput.txt',,file.,se.)

/* Sample data
file.1 = 'LLR'
file.2 = 'AAA = (BBB, BBB)'
file.3 = 'BBB = (AAA, ZZZ)'
file.4 = 'ZZZ = (ZZZ, ZZZ)'
file.0 = 4
*/
nodes. = ''
route. = ''

/* Parse the LRLRLRLR into our route stem */
do i = 1 to length(file.1)
  route.i = substr(file.1,i,1)
  route.0 = i
end

/* Create the network of nodes */
do i = 2 to file.0
  parse var file.i start "= ("l", "r")"
  start = strip(start)
  nodes.start.LEFT = strip(l)
  nodes.start.RIGHT = strip(r)
  /*say nodes.start.left","nodes.start.right*/
end

found = 0
i = 1
start = 'AAA'
finish = 'ZZZ'
do while(found=0)
  wstep = i
  do while(wstep > route.0)
    wstep = wstep - route.0
  end
  if route.wstep = 'L'
  then move = 'LEFT'
  else move = 'RIGHT'
  if nodes.start.move = finish then do
    say i "steps"
    found = 1
  end
  else do
    start = nodes.start.move
    i = i + 1
  end
end

exit

dfs: procedure expose nodes. route.
  /* Did not need it, as it runs into CONTROL STACK FULL and
     we van just loop as we done above, keeping code though :)
  */
  parse arg start,finish,step

  /* need clock math here */
  wstep = step
  do while(wstep > route.0)
    wstep = wstep - route.0
  end

  if route.wstep = 'L'
  then move = 'LEFT'
  else move = 'RIGHT'

  if nodes.start.move = finish then do
    /* thinking of last years monkeys: is this HEAD recursion? :) */
    return step
  end
  else do
    start = nodes.start.move
    step = step + 1
    return dfs(start,finish,step)
  end