/* REXX */

/* Sample data
file.1 = 'px{a<2006:qkq,m>2090:A,rfg}'
file.2 = 'pv{a>1716:R,A}'
file.3 = 'lnx{m>1548:A,A}'
file.4 = 'rfg{s<537:gd,x>2440:R,A}'
file.5 = 'qs{s>3448:A,lnx}'
file.6 = 'qkq{x<1416:A,crn}'
file.7 = 'crn{x>2662:A,R}'
file.8 = 'in{s<1351:px,qqz}'
file.9 = 'qqz{s>2770:qs,m<1801:hdj,R}'
file.10= 'gd{a>3333:R,R}'
file.11= 'hdj{m>838:A,pv}'
file.12= ''
file.13= '{x=787,m=2655,a=1222,s=2876}'
file.14= '{x=1679,m=44,a=2067,s=496}'
file.15= '{x=2036,m=264,a=79,s=2244}'
file.16= '{x=2461,m=1339,a=466,s=291}'
file.17= '{x=2127,m=1623,a=2188,s=1013}'
file.0 = 17
*/

x = bpxwunix('cat /z/zuserid/aoc2023/day19solutioninput.txt',,file.,se.)

state = 'rules'
workflows. = ''

part1 = 0

do i = 1 to file.0
  if state = 'shapes'then do
    parse var file.i wf"{x="vx",m="vm",a="va",s="vs"}"
    x = vx
    m = vm
    a = va
    s = vs
    in = 'in' /* why?? */
    k = bpm(in,x,m,a,s)
    do while k <> 'A' & k <> 'R'
      k = bpm(k,x,m,a,s)
    end
    if k = 'A' then
      part1=part1 + x + m + a + s
    say "Total sum:" part1
  end
  if file.i = '' then state = 'shapes'
  if state = 'rules' then do
    parse var file.i wf"{"rules"}"
    wf = strip(wf)
    rl = translate(rules,' ',',')
    r = ''
    do j = 1 to words(rl) - 1
      w = word(rl,j)
      v = substr(w,1,1)
      o = substr(w,2,1)
      a = substr(w,3)
      parse var a amount":"target
      r = r   v","o","amount","target
    end
    r = r' 'word(rl,words(rl))
    workflows.wf = r

  end
end

exit

bpm: procedure expose workflows.
  parse arg wfname,x,m,a,s
  r = workflows.wfname
  ans = 'NOT'
  do j = 1 to words(r)-1
    l = translate(word(r,j),' ',',')
    parse var l v o c rr
    if o = '<'  then do
      ans = lt(value(v),c,rr)
    end
    if o = '>'  then ans = gt(value(v),c,rr)
    if ans <> "NOT" then leave
  end
  if ans = "NOT" then ans = word(r,words(r))
  return ans

lt: procedure
  parse arg a,b,c
  if a < b then return c
  else return "NOT"

gt: procedure
  parse arg a,b,c
  if a > b then return c
  else return "NOT"
