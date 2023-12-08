/* REXX */
/* Sample data */
file.1 = 'Card  1: 20 72 30 38 18 65  6 55 70 27 | 12 28 47 50 60 17 14 25 41'
file.2 = 'Card  2: 15 98 12  3 20 60 58 54 34 18 | 98 23 12 19 61 38 11 43 58'
file.3 = 'Card  3: 47 97  2 80 89 56 66 85 62 46 | 78 97 47 14 15 85 42 66 24'
file.0 = 3
*/

x = bpxwunix('cat /z/userid/aoc2023/day4solutioninput.txt',,file.,se.)

copiesof. = 1
total = 0

do i = 1 to file.0
  parse var file.i "Card  "card":" winning "|" ours
  card = strip(card) 
  copiesof.0 = card
  points = 0  
  do n = 1 to words(ours)
    nmbr = word(ours,n)
    wewinone= wordpos(nmbr, winning)
    if wewinone > 0 then do
      points = points + 1
	  say "Card   "i":" nmbr
    end
  end
  do p = 1 to points
    ccard = card + p
    copiesof.ccard = copiesof.ccard + copiesof.card
  end
end
do i = 1 to copiesof.0
  total = total + copiesof.i
end
say "Day4_2 Total: "total