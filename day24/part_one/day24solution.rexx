/* REXX */

/* Sample data
file.1 = '19, 13, 30 @ -2,  1, -2'
file.2 = '18, 19, 22 @ -1, -1, -2'
file.3 = '20, 25, 34 @ -2, -2, -4'
file.4 = '12, 31, 28 @ -1, -2, -1'
file.5 = '20, 19, 15 @  1, -5, -3'
file.0 = 5
*/

x = bpxwunix('cat /z/zuserid/aoc2023/day24solutioninput.txt',,file.,se.)

NUMERIC DIGITS 15


h. = 0
do i = 1 to file.0
  parse var file.i x", "y", "z" @ "vx", "vy", "vz
  if vx > 0
  then ox = "+"
  else ox = "-"
  if vy > 0
  then oy = "+"
  else oy = "-"
  if vz > 0
  then oz = "+"
  else oz = "-"
  h.i.1.1 = x
  h.i.1.2 = ox || abs(vx)
  h.i.2.1 = y
  h.i.2.2 = oy || abs(vy)
  h.i.3.1 = z
  h.i.3.2 = oz || abs(vz)

end

part1 = 0
low = 200000000000000
high = 400000000000000

do a = 1 to file.0
  do b = a to file.0
    if a = b then iterate
    part1 = part1 + matchxy(a,b,low,high)
  end
end

say "Total sum:" part1



exit

matchxy: procedure expose h.
  parse arg a,b,lo,hi

  asx = h.a.1.1
  adx = h.a.1.2
  asy = h.a.2.1
  ady = h.a.2.2

  bsx = h.b.1.1
  bdx = h.b.1.2
  bsy = h.b.2.1
  bdy = h.b.2.2


  dx = bsx - asx
  dy = bsy - asy
  det = bdx * ady - bdy * adx
  if det = 0 then return 0 /* paralel lines */
  u = (dy * bdx - dx * bdy) / det
  v = (dy * adx - dx * ady) / det

  if u > 0 & v > 0 then do
    /* we intersect */
    px1 = asx + adx * u
    py1 = asy + ady * u
    px2 = bsx + bdx * v
    py2 = bsy + bdy * v
    if px1 >= lo & px1 <= hi & py1 >= lo & py2 <= hi then do
      /*
      say "intersect in target area at" px1","py1
      */
      return 1
    end
  end



  return 0

matchx: procedure expose h.
  parse arg a,b
  asx = h.a.1.1
  adx = h.a.1.2
  bsx = h.b.1.1
  bdx = h.b.1.2
  return (bsx-asx)/(bdx-adx)



lapse: procedure expose h.
  parse arg hs,t,d
  f = h.hs.d
  parse var f s op v
 /* say s op v */
  delta = op || v
  move = t * delta
  return s + move
