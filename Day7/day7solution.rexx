/* REXX */
x = bpxwunix('cat /z/zuserid/aoc2023/day7solutioninput.txt',,file.,se.)

NUMERIC DIGITS 15
/* Sample
file.1 = '32T3K 765'
file.2 = 'T55J5 684'
file.3 = 'KK677 28'
file.4 = 'KTJJT 220'
file.5 = 'QQQJA 483'
faile.0 = 5
*/

/* hands stem has index for the nth hand
   but also a .type

   hands.1 = '32T3K'
   hands.1.type = 'fiveofakind' (1)
   hands.1.bid  = 765

*/
hands. = ''
hands.0 = 0

/* because hands with same type are scored based on first
   card, we sort the cards first...
   but we want A > K > Q > J > T so we change them to
   A -> A
   K -> B
   Q -> C
   J -> D
   T -> E
*/


do i = 1 to file.0
  parse var file.i hand" "bid
  hands.hand = bid /* for easier lookup */
  hand = translate(hand,'ABCDEFGHIJKLMN','AKQJT987654321')
  newhand = hands.0 + 1
  hands.newhand = hand
  hands.newhand.bid = bid
  hands.newhand.type = handtype(hand)
  hands.0 = newhand
end

/* now we have it ready to 'sort' */
sortstring = ''
do i = 1 to hands.0
  sortstring = sortstring || '\n' || hands.i.type || ":"hands.i
end

sortcmd = 'echo "' || sortstring || '" | sort'
x = bpxwunix(sortcmd,,sorted.,err.)

/* now we take the cardbits, and sort them again */
sortstring = ''
do i = 1 to sorted.0
  parse var sorted.i type":"card
  sortstring = sortstring || '\n' || sorted.i
end
sortcmd = 'echo "' || sortstring || '" | sort -r'
x = bpxwunix(sortcmd,,sorted.,err.)

say i 'hands sorted'
say sorted.0 'hand back'
p1 = 0

do i = 1 to sorted.0
  if sorted.i = '' then iterate /* pesky newlines */
  cdat = translate(sorted.i,'AKQJT987654321','ABCDEFGHIJKLMN')
  say cdat
  parse var cdat idx":"card
  card = strip(card)
  bid = hands.card
  p1 = p1 + (bid * i)
end

say "Part one:" p1

exit

handtype: procedure
  parse arg h

  labels. = 0
  labellist = ''

  do i = 1 to length(h)
    label = substr(h,i,1)
    labels.label = labels.label + 1
    if wordpos(label, labellist) = 0 then
      labellist = labellist label
  end

  state = ''
  /* Determine type */
  do j = 1 to words(labellist)
    l = word(labellist,j)
    if labels.l = 5 then return 1
    if labels.l = 4 then return 2
    if labels.l = 3 &   state = 'pair' then return 3
    if labels.l = 3 &   state = '' then state = 'toak'
    if labels.l = 2 &   state = 'pair' then return 5
    if labels.l = 2 &   state = 'toak' then return 3
    if labels.l = 2 &   state = '' then state = 'pair'
  end

  if state = 'toak' then return 4
  if state = 'pair' then return 6
  return 7


