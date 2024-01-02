/* REXX */

x = bpxwunix('cat /z/zuserid/aoc2023/day17solutioninput.txt',,file.,se.)

/* Sample data
file.1 = '2413432311323'
file.2 = '3215453535623'
file.3 = '3255245654254'
file.4 = '3446585845452'
file.5 = '4546657867536'
file.6 = '1438598798454'
file.7 = '4457876987766'
file.8 = '3637877979653'
file.9 = '4654967986887'
file.10= '4564679986453'
file.11= '1224686865563'
file.12= '2546548887735'
file.13= '4322674655533'
file.0 = 13
*/

grid. = -1

/* Parse cityblock map */
do i = 1 to file.0
  do j = 1 to length(file.i)
    grid.j.i = substr(file.i,j,1)
  end
end


maxx = length(file.1)
maxy = file.0

start = "1,1"
finish = maxx || "," || maxy
lowest = 99999999999999
cost.  = -1

p = seek(start, finish, '1,0')


say "Total sum:" p
v = 0
do j = 1 to words(p)
  w = word(p,j)
  parse var w loc"|"dir"|"cst
  parse var loc xl","yl
  v = v + grid.xl.yl
end
/* say v */

exit

seek: procedure expose maxx maxy grid. lowest queue. cost.
  parse arg start,finish,dir
  parse var current xs","ys

  queue.1 = start"|"dir"|"0
  queue.0 = 1
  seen = ''

  do while queue.0 > 0
   /* say "qdepth=" queue.0 */
    path = queuepopleft()
   /* say "path =" path */
    last = word(path,words(path))
    parse var last clas"|"cdir"|"cost
    if cost.cost > 0 then iterate
    if wordpos(clas,seen) = 0 then do
      seen = seen strip(last)
      if clas = finish then do
        return path
      end
      /* what are our options? */
      parse var last lloc"|"dir"|"cost
      opts = ''
      ldir = turn_left(dir)
      rdir = turn_right(dir)
      opts = moves(lloc,dir,opts)
      if words(opts) = 0 then
        opts = moves(lloc,rdir,opts)
      if words(opts) = 0 then
        opts = moves(lloc,ldir,opts)
      /* get lowest values */
      nopts = ''
      lowest = 10
      do o = 1 to words(opts)
        nopt = word(opts,o)
        parse var nopt nloc"|"dir
        parse var nloc xn","yn
        if grid.xn.yn < lowest then do
          nopts = nopts nopt
          lowest = grid.nx.ny
        end
      end
      /* try these values */
      opts = nopts
     /* say "trying" opts */
      do o = 1 to words(opts)
        opt = word(opts,o)
        newpath = path opt
        notin = 1
        do nn = 1 to queue.0
          if queue.nn = newpath then do
            notin = 0
            leave
          end
        end
        if notin = 1 then do
          nq = queue.0 + 1
          queue.nq = newpath
          queue.0 = nq
        end
      end
    end
  end


queuepopleft: procedure expose queue.
  localq. = 0
  doneathing = 0
  res = queue.1
  if queue.0 = 1 then do
    queue.0 = 0
    return queue.1
  end
  do i = 2 to queue.0
    nl = localq.0 + 1
    localq.nl = queue.i
    localq.0 = nl
    doneathing = 1
  end
  if doneathing = 1 then do
    queue.0 = queue.0 -1
    do i = 1 to queue.0
      queue.i = localq.i
    end
    return res
  end



moves: procedure expose maxx maxy
  parse arg curr,dir,curropts
  parse var curr xc","yc
  parse var dir  xd","yd
  do i = 3 to 1 by -1
    xc = xc + xd
    yc = yc + yd
    if xc > 0 & xc <= maxx & yc > 0 & yc <= maxy then do
      newloc = xc ||","||yc
      newopt = newloc'|'dir
      if wordpos(newopt,curropts) = 0 then
        curropts = curropts newopt
    end
  end
  return curropts

turn_left: procedure
  parse arg dir
  if dir = "1,0" then return "0,-1"
  if dir = "-1,0" then return "0,1"
  if dir = "0,1" then return "1,0"
  if dir = "0,-1" then return "-1,0"
 /* say dir */

turn_right: procedure
  parse arg dir
  if dir = "1,0" then return "0,1"
  if dir = "-1,0" then return "0,-1"
  if dir = "0,1" then return "-1,0"
  if dir = "0,-1" then return "1,0"

pathval: procedure expose grid.
  parse arg path
  v = 0
  p = translate(path,' ','-')
  do pp = 2 to words(p)
    ploc = word(p,pp)
    parse var ploc xp","yp
    v = v + grid.xp.yp
  end
  return v
